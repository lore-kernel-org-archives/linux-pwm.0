From: "Jingoo Han" <jingoohan1@gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: make of_device_ids const
Date: Tue, 20 Jun 2017 09:59:06 -0400
Message-ID: <000001d2e9cd$624285e0$26c791a0$@gmail.com>
References: <b9daeb15d40f6682803d8dafde3bc3dcb63909ff.1497940816.git.arvind.yadav.cs@gmail.com> <2574238d-640f-79b3-4650-c51766b4a478@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2574238d-640f-79b3-4650-c51766b4a478@linaro.org>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Daniel Thompson' <daniel.thompson@linaro.org>, 'Arvind Yadav' <arvind.yadav.cs@gmail.com>, thierry.reding@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tuesday, June 20, 2017 6:53 AM, Daniel Thompson wrote:
> 
> On 20/06/17 08:52, Arvind Yadav wrote:
> > of_device_ids are not supposed to change at runtime. All functions
> > working with of_device_ids provided by <linux/of.h> work with const
> > of_device_ids. So mark the non-const structs as const.
> >
> > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> 
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> 
> 
> > ---
> >   drivers/video/backlight/pwm_bl.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/video/backlight/pwm_bl.c
> b/drivers/video/backlight/pwm_bl.c
> > index 002f1ce..9bd1768 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -178,7 +178,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
> >   	return 0;
> >   }
> >
> > -static struct of_device_id pwm_backlight_of_match[] = {
> > +static const struct of_device_id pwm_backlight_of_match[] = {
> >   	{ .compatible = "pwm-backlight" },
> >   	{ }
> >   };
> >
