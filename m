From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND 07/11] pwm: sti: Initialise PWM Capture channel data
Date: Fri, 15 Apr 2016 13:39:41 +0100
Message-ID: <20160415123941.GD3589@x1>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-8-git-send-email-lee.jones@linaro.org>
 <20160412102926.GC18882@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35746 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbcDOMjq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Apr 2016 08:39:46 -0400
Received: by mail-wm0-f52.google.com with SMTP id a140so29574790wma.0
        for <linux-pwm@vger.kernel.org>; Fri, 15 Apr 2016 05:39:45 -0700 (PDT)
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
>=20
> On a side-note, this should probably use struct gpio_desc * instead o=
f
> an integer along with the gpiod_*() APIs for the GPIO handling.

Why would you need to do that?

of_get_named_gpio() does all that for you.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
