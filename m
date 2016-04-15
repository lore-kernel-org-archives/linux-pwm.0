From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND 07/11] pwm: sti: Initialise PWM Capture channel data
Date: Fri, 15 Apr 2016 15:31:22 +0100
Message-ID: <20160415143122.GF3589@x1>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-8-git-send-email-lee.jones@linaro.org>
 <20160412102926.GC18882@ulmo.ba.sec>
 <20160415123941.GD3589@x1>
 <20160415142243.GE3472@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38280 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbcDOOb2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Apr 2016 10:31:28 -0400
Received: by mail-wm0-f41.google.com with SMTP id u206so35110866wme.1
        for <linux-pwm@vger.kernel.org>; Fri, 15 Apr 2016 07:31:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160415142243.GE3472@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com

On Fri, 15 Apr 2016, Thierry Reding wrote:

> On Fri, Apr 15, 2016 at 01:39:41PM +0100, Lee Jones wrote:
> > On Tue, 12 Apr 2016, Thierry Reding wrote:
> >=20
> > > On Wed, Mar 02, 2016 at 03:32:05PM +0000, Lee Jones wrote:
> > > [...]
> > > > +struct sti_cpt_data {
> > > > +	u32 snapshot[3];
> > > > +	int index;
> > > > +	int gpio;
> > >=20
> > > On a side-note, this should probably use struct gpio_desc * inste=
ad of
> > > an integer along with the gpiod_*() APIs for the GPIO handling.
> >=20
> > Why would you need to do that?
> >=20
> > of_get_named_gpio() does all that for you.
>=20
> Use the of_get_named_gpio*d*() function instead. My understanding is
> that referring to GPIOs by integer is deprecated and should not be us=
ed
> in new code.

I've since conducted some research and have now converted over to
gpiod.  Thanks for the pointer.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
