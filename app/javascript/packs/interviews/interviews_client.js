export class InterviewClient {
  search({url, token}, callback) {
    $.ajax({
      url,
      method: 'GET',
      headers: { 'Content-Type': 'application/json' },
      dateType: 'json',
      success: res => {
        callback(res)
      },
      error: (res, status, error) => {
        callback(res, error)
      }
    })
  }

  create(interview, {url, token}, callback) {
    $.ajax({
      url,
      method: 'POST',
      dateType: 'json',
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

  update(interview, {url, token}, callback) {
    $.ajax({
      url,
      method: 'PATCH',
      dateType: 'json',
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