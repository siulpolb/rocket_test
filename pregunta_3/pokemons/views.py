import csv
import io

from rest_framework.parsers import FormParser, MultiPartParser
from rest_framework.response import Response
from rest_framework.views import APIView

# Create your views here.
class PokemonList(APIView):
    parser_classes = [FormParser, MultiPartParser]

    def post(self, request):
        response = []
        status = 200
        param_filter = request.query_params.get('filter', '')
        file_obj = request.data.get('file')
        decoded_file = file_obj.read().decode('utf-8')
        io_string = io.StringIO(decoded_file)
        csv_reader = csv.DictReader(io_string)
        for row in csv_reader:
            try:
                if param_filter in row['NAME']:
                    response.append(row['NAME'])
            except KeyError:
                response = {'message': 'File has the wrong format'}
                status = 400

        return Response(data=response, status=status)
