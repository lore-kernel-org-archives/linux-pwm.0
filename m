From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v12 09/11] backlight: pwm_bl: Use 64-bit division function
Date: Thu, 16 Apr 2020 10:55:27 -0700
Message-ID: <20200416175527.GA21388@codeaurora.org>
References: <cover.1586414867.git.gurus@codeaurora.org>
 <e2139a83008e9f301889f9384487c55de475a6a2.1586414867.git.gurus@codeaurora.org>
 <20200416094420.GB2167633@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:37671 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728445AbgDPRzy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Apr 2020 13:55:54 -0400
Content-Disposition: inline
In-Reply-To: <20200416094420.GB2167633@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

On Thu, Apr 16, 2020 at 10:44:20AM +0100, Lee Jones wrote:
> On Wed, 08 Apr 2020, Guru Das Srinagesh wrote:
> 
> > Since the PWM framework is switching struct pwm_state.period's datatype
> > to u64, prepare for this transition by using div_u64 to handle a 64-bit
> > dividend instead of a straight division operation.
> > 
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: linux-pwm@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > 
> > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  drivers/video/backlight/pwm_bl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> I see that this is part of a large set, but the remainder of the
> patches have been hidden from me.

Sorry about that, the full series is here: [1].

> Does this mean I can apply this patch on its own?

I'll defer to Uwe on this point as I am not sure of the implications of
taking in this single patch and not the entire series.

Thank you.

Guru Das.

[1] https://www.spinics.net/lists/linux-pwm/msg12131.html
