export class InterviewClient {
  search(callback) {
    $.ajax({
      url: '/candidates',
      method: 'GET',
      headers: { 'Content-Type': 'application/json' },
      dateType: 'json',
      success: res => {
        callback(res);
      }
    });
  }

  create(interview, {url, token}, callback) {
    $.ajax({
      url,
      method: 'POST',
      dateType: 'json',
      // headers: { 'X-CSRF-Token': token },
      data: {
        interview,
        authenticity_token: token
      },
      success: res => {
        callback(res)
      },
      error: (res, status, error) => {
        callback(res, error)
      }
    })
  }
}