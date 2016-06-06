From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 00/11] pwm: Add support for PWM Capture
Date: Mon, 6 Jun 2016 16:32:31 +0100
Message-ID: <20160606153231.GE1525@dell>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
 <20160429094010.6bfb131c@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38124 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbcFFPcB (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jun 2016 11:32:01 -0400
Received: by mail-wm0-f41.google.com with SMTP id m124so77465793wme.1
        for <linux-pwm@vger.kernel.org>; Mon, 06 Jun 2016 08:32:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160429094010.6bfb131c@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, kernel@stlinux.com, ajitpal.singh@st.com, thierry.reding@gmail.com, maxime.coquelin@st.com

On Fri, 29 Apr 2016, Boris Brezillon wrote:

> Hi Lee,
>=20
> On Fri, 22 Apr 2016 11:18:04 +0100
> Lee Jones <lee.jones@linaro.org> wrote:
>=20
> > The first part of this set extends the current PWM API to allow ext=
ernal
> > code to request a PWM Capture.  Subsequent patches then make use of=
 the
> > new API by providing a userspace offering via /sysfs.  The final pa=
rt of
> > the set supplies PWM Capture functionality into the already existin=
g STi
> > PWM driver.
>=20
> Is there a reason you decided to not put this driver in IIO? IMHO, it
> would be more appropriate to make your PWM device an MFD that can eit=
her
> bind to the PWM or the capture driver.
> And BTW, IIO already has a sysfs interface (you may have to extend th=
e
> API to support your type of capture though).

Multi-Function Device drivers can only be justified if the IP
contained does not and can not live in a single subsystem.  The IP
which controls both PWM-in and PWM-out in this device is the same.  I
can't fathom a sane reason why you would wish to separate this
functionality over multiple subsystems.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
