From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 10/20] pwm: sysfs: Add PWM Capture support
Date: Fri, 10 Jun 2016 15:36:27 +0100
Message-ID: <20160610143627.GD1537@dell>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-11-lee.jones@linaro.org>
 <20160610140404.GL27142@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37205 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbcFJOfw (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jun 2016 10:35:52 -0400
Received: by mail-wm0-f53.google.com with SMTP id k204so104933901wmk.0
        for <linux-pwm@vger.kernel.org>; Fri, 10 Jun 2016 07:35:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160610140404.GL27142@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, patrice.chotard@st.com, robh+dt@kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org

On Fri, 10 Jun 2016, Thierry Reding wrote:

> On Wed, Jun 08, 2016 at 10:21:25AM +0100, Lee Jones wrote:
> > Allow a user to read PWM Capture results from /sysfs.
> >=20
> > To start a capture and read the result, simply read the file:
> >=20
> >   $ cat $PWMCHIP/capture
> >=20
> > The output format is "<period>:<duty_cycle>".
>=20
> The format below is "<period> <duty cycle>".
>=20
> No need to rev the series for this, I can take patches 8 and 10 as-is
> and make those modifications myself.

Ideal, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
