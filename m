From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v12 08/11] pwm: sun4i: Use nsecs_to_jiffies to avoid a division
Date: Sat, 11 Apr 2020 13:49:02 +0800
Message-ID: <CAGb2v67r_esaqANauo7YOVjSVVt5z+jyuneZe0FLrjgDxnDjzA@mail.gmail.com>
References: <cover.1586414867.git.gurus@codeaurora.org> <436e1a50e603eefb24c8e7b2bd7f7e4838b90e12.1586414867.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39120 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgDKFtO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 11 Apr 2020 01:49:14 -0400
In-Reply-To: <436e1a50e603eefb24c8e7b2bd7f7e4838b90e12.1586414867.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>

On Thu, Apr 9, 2020 at 2:53 PM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>
> Since the PWM framework is switching struct pwm_state.period's datatype
> to u64, prepare for this transition by using nsecs_to_jiffies() which
> does away with the need for a division operation.
>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
