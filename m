From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 08/20] pwm: Add PWM Capture support
Date: Mon, 20 Jun 2016 12:14:42 +0100
Message-ID: <20160620111442.GA4490@dell>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-9-lee.jones@linaro.org>
 <20160610135302.GK27142@ulmo.ba.sec>
 <20160610143854.GE1537@dell>
 <20160610163956.GA8696@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36385 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932502AbcFTLN6 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jun 2016 07:13:58 -0400
Received: by mail-wm0-f48.google.com with SMTP id f126so64713767wma.1
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jun 2016 04:13:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160610163956.GA8696@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, patrice.chotard@st.com, robh+dt@kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org

On Fri, 10 Jun 2016, Thierry Reding wrote:

> On Fri, Jun 10, 2016 at 03:38:54PM +0100, Lee Jones wrote:
> > On Fri, 10 Jun 2016, Thierry Reding wrote:
> >=20
> > > On Wed, Jun 08, 2016 at 10:21:23AM +0100, Lee Jones wrote:
> > > > Supply a PWM Capture call-back Op in order to pass back
> > > > information obtained by running analysis on PWM a signal.
> > > > This would normally (at least during testing) be called from
> > > > the Sysfs routines with a view to printing out PWM Capture
> > > > data which has been encoded into a string.
> > > >=20
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/pwm/core.c  | 27 +++++++++++++++++++++++++++
> > > >  include/linux/pwm.h | 25 +++++++++++++++++++++++++
> > > >  2 files changed, 52 insertions(+)
> >=20
> > So do you want me to re-spin?
> >=20
> > Before you said you'd make adjustments on patches 8 through 10, so =
I'm
> > a little confused.
>=20
> Yeah, I only realized that it might be quicker to make these adjustme=
nts
> myself when I had finished looking at patch 10. I've pushed the adjus=
ted
> patches to a for-4.8/pwm-capture branch, so if you're going to re-spi=
n
> the remainder of the patches, perhaps that could be your base?
>=20
> 	https://git.kernel.org/cgit/linux/kernel/git/thierry.reding/linux-pw=
m.git/log/?h=3Dfor-4.8/pwm-capture
>=20
> If you don't have any objections I can put those into linux-next earl=
y
> next week.

That's fine by me.  I will rebase.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
