From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/4] backlight: pwm_bl: fix cie1913 comments and
 constant
Date: Mon, 14 Oct 2019 08:27:10 +0100
Message-ID: <20191014072710.GE4545@dell>
References: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
 <20191008120327.24208-2-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191008120327.24208-2-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, 08 Oct 2019, Rasmus Villemoes wrote:

> The "break-even" point for the two formulas is L==8, which is also
> what the code actually implements. [Incidentally, at that point one
> has Y=0.008856, not 0.08856].
> 
> Moreover, all the sources I can find say the linear factor is 903.3
> rather than 902.3, which makes sense since then the formulas agree at
> L==8, both yielding the 0.008856 figure to four significant digits.
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/video/backlight/pwm_bl.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
