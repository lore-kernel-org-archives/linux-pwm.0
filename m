From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v2 RESEND] video: backlight: pwm_bl: Initialize
 fb_bl_on[x] and use_count during pwm_backlight_probe()
Date: Mon, 23 Jan 2017 01:50:41 +0100
Message-ID: <20170123015041.34b8e64d@jawa>
References: <1477169904-14997-1-git-send-email-l.majewski@majess.pl>
        <1482790896-29202-1-git-send-email-l.majewski@majess.pl>
        <20170103083032.GA2977@dell>
        <20170113012737.45f5a3db@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:46511 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdAWAuo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 22 Jan 2017 19:50:44 -0500
In-Reply-To: <20170113012737.45f5a3db@jawa>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Liu Ying <Ying.Liu@freescale.com>, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Dear All,

> Dear All,
> 
> > Thierry, Jingoo,
> > 
> > Please respond to Lukasz.
> 
> Yes, your response is more than welcome....... :-)

More, more than welcome.

Ping for this patch. I do understand that kernel developers are busy
people, but this patch is not reviewed since Nov last year :-)

> 
> Thanks in advance,
> 
> Łukasz Majewski
> 
> > 
> > On Mon, 26 Dec 2016, Lukasz Majewski wrote:
> > 
> > > The commit a55944ca82d2 
> > > ("backlight: update bd state & fb_blank properties when
> > > necessary") has posed some extra restrictions on blanking and
> > > unblanking frame buffer device.
> > > 
> > > Unfortunately, pwm_bl driver's probe did not initialize members of
> > > struct backlight_device necessary for further blank/unblank
> > > operation.
> > > 
> > > This code in case of initial unblank of backlight device (default 
> > > behaviour) sets use_count to 1 and marks this particular backlight
> > > device as used by all available fb devices (since it is not known
> > > during probe how much and which fb devices will be assigned).
> > > 
> > > Without this code, the backlight works properly until one tries to
> > > blank it manually from sysfs with "echo 1
> > > > /sys/class/graphics/fb0/blank". Since fb_bl_on[0] and use_count
> > > > were both set to 0, the logic at
> > > fb_notifier_callback (@backlight.c) thought that we didn't turn on
> > > (unblanked) the backlight device and refuses to disable (blank)
> > > it. As a result we see garbage from fb displayed.
> > > 
> > > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > > ---
> > > The patch has been tested on i.MX6q with vanilla 4.9 kernel.
> > > It applies on 4.10-rc1.
> > > ---
> > >  drivers/video/backlight/pwm_bl.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/video/backlight/pwm_bl.c
> > > b/drivers/video/backlight/pwm_bl.c index 1261400..6859ba0 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -202,7 +202,7 @@ static int pwm_backlight_probe(struct
> > > platform_device *pdev) struct pwm_bl_data *pb;
> > >  	int initial_blank = FB_BLANK_UNBLANK;
> > >  	struct pwm_args pargs;
> > > -	int ret;
> > > +	int ret, i;
> > >  
> > >  	if (!data) {
> > >  		ret = pwm_backlight_parse_dt(&pdev->dev,
> > > &defdata); @@ -348,6 +348,14 @@ static int
> > > pwm_backlight_probe(struct platform_device *pdev) 
> > >  	bl->props.brightness = data->dft_brightness;
> > >  	bl->props.power = initial_blank;
> > > +
> > > +	if (initial_blank == FB_BLANK_UNBLANK) {
> > > +		for (i = 0; i < FB_MAX; i++)
> > > +			bl->fb_bl_on[i] = true;
> > > +
> > > +		bl->use_count = 1;
> > > +	}
> > > +
> > >  	backlight_update_status(bl);
> > >  
> > >  	platform_set_drvdata(pdev, bl);
> > 
> 
> Best regards,
> 
> Lukasz Majewski
> 
> --
> 
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
