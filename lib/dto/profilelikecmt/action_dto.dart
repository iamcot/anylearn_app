class ActionDTO {
    ActionDTO({
        this.result,
    });

    int? result;

    factory ActionDTO.fromJson(Map<String, dynamic> json) => ActionDTO(
        result: json["result"] ?? 0,
    );

}
