from flask import Flask, request, send_file, render_template_string
import io
from PIL import Image
import cairosvg

app = Flask(__name__)

@app.route('/', methods=['GET'])
def index():
    return '''
    <form method="POST" action="/generate" enctype="multipart/form-data">
        <textarea name="svgcode" rows="20" cols="50"></textarea><br>
        <input type="submit" value="Generate Image">
    </form>
    '''

@app.route('/generate', methods=['POST'])
def generate_image():
    svg_code = request.form.get('svgcode')

    if not svg_code:
        return "SVG code is required", 400

    try:
        # 将SVG转换为PNG
        png_image = cairosvg.svg2png(bytestring=svg_code.encode('utf-8'))
        img_io = io.BytesIO(png_image)
        img_io.seek(0)

        return send_file(img_io, mimetype='image/png', as_attachment=True, download_name='output.png')

    except Exception as e:
        return f"An error occurred: {str(e)}", 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)

