From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND 07/11] pwm: sti: Initialise PWM Capture channel data
Date: Fri, 15 Apr 2016 14:11:46 +0100
Message-ID: <20160415131146.GE3589@x1>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-8-git-send-email-lee.jones@linaro.org>
 <20160412102926.GC18882@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37362 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbcDONLv (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Apr 2016 09:11:51 -0400
Received: by mail-wm0-f48.google.com with SMTP id n3so31930311wmn.0
        for <linux-pwm@vger.kernel.org>; Fri, 15 Apr 2016 06:11:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160412102926.GC18882@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com

On Tue, 12 Apr 2016, Thierry Reding wrote:
> On Wed, Mar 02, 2016 at 03:32:05PM +0000, Lee Jones wrote:
> [...]
> > +struct sti_cpt_data {
> > +	u32 snapshot[3];
> > +	int index;
> > +	int gpio;

[...]

> > +
> > +		init_waitqueue_head(&data->wait);
> > +		mutex_init(&data->lock);
> > +		data->gpio =3D of_get_named_gpio(np, "capture-gpios", chan);
> > +		pc->cpt_data[chan] =3D data;
>=20
> Converting to per-PWM data should be as simple as turning this last l=
ine
> into:
>=20
> 	pwm_set_chip_data(pc->chip.pwms[chan], data);
>=20
> Also I don't see any cleanup for this data in the driver. The memory =
for
> the per-PWM data should be freed by devm_*() infrastructure, but how
> will the GPIO be released?

There is no reason to release a GPIO.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
