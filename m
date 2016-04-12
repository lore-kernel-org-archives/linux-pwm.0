From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND 00/11] pwm: Add support for PWM Capture
Date: Tue, 12 Apr 2016 08:28:49 +0100
Message-ID: <20160412072849.GH8094@x1>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36011 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450AbcDLH2x (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Apr 2016 03:28:53 -0400
Received: by mail-wm0-f54.google.com with SMTP id v188so114955863wme.1
        for <linux-pwm@vger.kernel.org>; Tue, 12 Apr 2016 00:28:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com

On Wed, 02 Mar 2016, Lee Jones wrote:

> The first part of this set extends the current PWM API to allow exter=
nal
> code to request a PWM Capture.  Subsequent patches then make use of t=
he
> new API by providing a userspace offering via /sysfs.  The final part=
 of
> the set supplies PWM Capture functionality into the already existing =
STi
> PWM driver.
> =20
> This patch-set has been tested end to end via /sysfs.

Hopefully you still have this set in your inbox.

Please let me know if you wish me to resend it.

> Lee Jones (11):
>   pwm: Add PWM Capture support
>   pwm: sysfs: Add PWM Capture support
>   pwm: sti: Reorganise register names in preparation for new
>     functionality
>   pwm: sti: Only request clock rate when you need to
>   pwm: sti: Supply PWM Capture register addresses and bit locations
>   pwm: sti: Supply PWM Capture clock handling
>   pwm: sti: Initialise PWM Capture channel data
>   pwm: sti: Add support for PWM Capture IRQs
>   pwm: sti: Add PWM Capture call-back
>   pwm: sti: Enable PWM Capture
>   pwm: sti: Take the opportunity to conduct a little house keeping
>=20
>  drivers/pwm/core.c    |  26 ++++
>  drivers/pwm/pwm-sti.c | 384 ++++++++++++++++++++++++++++++++++++++++=
++--------
>  drivers/pwm/sysfs.c   |  28 ++++
>  include/linux/pwm.h   |  13 ++
>  4 files changed, 392 insertions(+), 59 deletions(-)
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
