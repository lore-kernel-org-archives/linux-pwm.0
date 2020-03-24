From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v11 10/12] backlight: pwm_bl: Use 64-bit division function
Date: Tue, 24 Mar 2020 13:57:35 +0100
Message-ID: <20200324125735.2mjuvbxt5bpon2ft@pengutronix.de>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <17fc1dcf8b9b392d1e37dc7e3e67409e3c502840.1584667964.git.gurus@codeaurora.org>
 <20200320133123.GD5477@dell>
 <20200324110710.GL5477@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59733 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgCXM5q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Mar 2020 08:57:46 -0400
Content-Disposition: inline
In-Reply-To: <20200324110710.GL5477@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Guru Das Srinagesh <gurus@codeaurora.org>, linux-pwm@vger.kernel.org, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

Hello Lee,

On Tue, Mar 24, 2020 at 11:07:10AM +0000, Lee Jones wrote:
> On Fri, 20 Mar 2020, Lee Jones wrote:
> 
> > On Thu, 19 Mar 2020, Guru Das Srinagesh wrote:
> > 
> > > Since the PWM framework is switching struct pwm_state.period's datatype
> > > to u64, prepare for this transition by using div_u64 to handle a 64-bit
> > > dividend instead of a straight division operation.
> > > 
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Cc: linux-pwm@vger.kernel.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-fbdev@vger.kernel.org
> > > 
> > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > ---
> > >  drivers/video/backlight/pwm_bl.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Can this patch be taken on its own?
> 
> Hellooooo ...

Conceptually it can. As the last patch depends on this one (and the
others) some coordination might be beneficial. But that's up to Thierry
to decide how (and if) he want this series to be applied.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
