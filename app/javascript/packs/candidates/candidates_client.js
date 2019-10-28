export class CandidatesClient {
  search(callback) {
    $.ajax({
      url: '/candidates',
      method: 'GET',
      headers: { 'Content-Type': 'application/json' },
      dataType: 'json',
      success: (res) => {
        callback(res);
      }
    });
  }
}
