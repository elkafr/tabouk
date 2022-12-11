class Miza {
   Miza({
        this.mizaId,
        this.mizaTitle,
    });

    String mizaId;
    String mizaTitle;

    factory Miza.fromJson(Map<String, dynamic> json) => Miza(
      mizaId: json["miza_id"],
      mizaTitle: json["miza_title"],
    );

    Map<String, dynamic> toJson() => {
        "miza_id": mizaId,
        "miza_title": mizaTitle,
    };
}
