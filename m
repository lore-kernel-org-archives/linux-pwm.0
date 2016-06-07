From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 00/11] pwm: Add support for PWM Capture
Date: Tue, 7 Jun 2016 08:46:01 +0100
Message-ID: <20160607074601.GF1525@dell>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
 <20160429094010.6bfb131c@bbrezillon>
 <20160606153231.GE1525@dell>
 <20160606204603.09a8d2cf@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160606204603.09a8d2cf@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, kernel@stlinux.com, ajitpal.singh@st.com, thierry.reding@gmail.com, maxime.coquelin@st.com
List-Id: linux-pwm@vger.kernel.org

On Mon, 06 Jun 2016, Boris Brezillon wrote:

> On Mon, 6 Jun 2016 16:32:31 +0100
> Lee Jones <lee.jones@linaro.org> wrote:
>=20
> > On Fri, 29 Apr 2016, Boris Brezillon wrote:
> >=20
> > > Hi Lee,
> > >=20
> > > On Fri, 22 Apr 2016 11:18:04 +0100
> > > Lee Jones <lee.jones@linaro.org> wrote:
> > >  =20
> > > > The first part of this set extends the current PWM API to allow=
 external
> > > > code to request a PWM Capture.  Subsequent patches then make us=
e of the
> > > > new API by providing a userspace offering via /sysfs.  The fina=
l part of
> > > > the set supplies PWM Capture functionality into the already exi=
sting STi
> > > > PWM driver. =20
> > >=20
> > > Is there a reason you decided to not put this driver in IIO? IMHO=
, it
> > > would be more appropriate to make your PWM device an MFD that can=
 either
> > > bind to the PWM or the capture driver.
> > > And BTW, IIO already has a sysfs interface (you may have to exten=
d the
> > > API to support your type of capture though). =20
> >=20
> > Multi-Function Device drivers can only be justified if the IP
> > contained does not and can not live in a single subsystem.  The IP
> > which controls both PWM-in and PWM-out in this device is the same. =
 I
> > can't fathom a sane reason why you would wish to separate this
> > functionality over multiple subsystems.
> >=20
>=20
> Well, I still think what you describe as PWM-in is actually a capture
> device that would perfectly fit in the IIO subsystem, and I guess you
> can't use the PWM IP as a capture and waveform generator device as th=
e
> same time, which is why I suggested the MFD approach to select the mo=
de.

We only tend to place devices in IIO if they do not fit anywhere
else.  There are lots of unidirectional and bidirectional capture
devices that belong in other subsystems.

This is a PWM device through and through, and the API fits in
perfectly with the remainder of the subsystem.  To attempt to manage
and maintain similar functionality spread over more than one subsystem
when there is no clear requirement (like there is with a chip
containing a GPIO, Regulator and HWMON components for inistance),
would be unnecessarily over-complicating matters.

> Anyway, I'm not the PWM or the IIO maintainer, so I'm just sharing my
> opinion here.
>=20
> Regards,
>=20
> Boris
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
