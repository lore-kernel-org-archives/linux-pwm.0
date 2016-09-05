From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Mon, 5 Sep 2016 12:01:15 +0200
Message-ID: <20160905100115.GC31424@ulmo.ba.sec>
References: <1471852213-86777-1-git-send-email-yuanjian12@hisilicon.com>
 <20160824130546.GD3714@ulmo.ba.sec>
 <09f4946b-0e67-d2f7-cb43-03dead1ec4a9@hisilicon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33782 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933122AbcIEKBS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Sep 2016 06:01:18 -0400
Content-Disposition: inline
In-Reply-To: <09f4946b-0e67-d2f7-cb43-03dead1ec4a9@hisilicon.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jian Yuan <yuanjian12@hisilicon.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, xuejiancheng@hisilicon.com, kevin.lixu@hisilicon.com, jalen.hsu@hisilicon.com


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2016 at 05:15:36PM +0800, Jian Yuan wrote:
>=20
>=20
> On 2016/8/24 21:05, Thierry Reding wrote:
> > On Mon, Aug 22, 2016 at 03:50:13PM +0800, Jian Yuan wrote:
> >> From: yuanjian <yuanjian12@hisilicon.com>
> >>
> >> Add pwm driver for HiSilicon BVT SOCs
> >=20
> > pwm -> PWM, please. It'd be good to have more information here about
> > what the hardware can do, where to find it, etc.
> >=20
> Not sure what you mean? Should I describe what the PWM or the BVT SoCs ca=
n do?

Some of the things you could mention here are how many channels the PWM
controller supports, if there any noteworthy limitations or extra
features. Looking at the driver the controller is pretty standard, but
you could mention that it supports signal polarity (not all controllers
do) and that it can be found on two SoCs and name them. Sometimes it's
also useful to give some information about typical use-cases (perhaps
one of the PWMs is used to control backlight of a panel with some widely
available development board?).

> >> Reviewed-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
> >> Signed-off-by: Jian Yuan <yuanjian12@hisilicon.com>
> >> ---
> >> Change Log:
> >> v2:
> >> The number of PWMs is change to be probeable based on the compatible s=
tring.
> >>
> >>  .../devicetree/bindings/pwm/pwm-hibvt.txt          |  18 ++
> >>  drivers/pwm/Kconfig                                |  10 +
> >>  drivers/pwm/Makefile                               |   1 +
> >>  drivers/pwm/pwm-hibvt.c                            | 274 ++++++++++++=
+++++++++
> >>  4 files changed, 303 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
> >>  create mode 100644 drivers/pwm/pwm-hibvt.c
> >>
> >> diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Doc=
umentation/devicetree/bindings/pwm/pwm-hibvt.txt
> >> new file mode 100644
> >> index 0000000..1274119
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
> >> @@ -0,0 +1,18 @@
> >> +Hisilicon PWM controller
> >> +
> >> +Required properties:
> >> +-compatible: should contain one soc specific compatible string and on=
e generic compatible
> >> +string "hisilicon, hibvt-pwm". The soc specific strings supported inc=
luding:
> >=20
> > Why the generic compatible string? You've already shown in the driver
> > that the two versions you support aren't compatible.
> >
> The generic compatible string should be contained in every devicetree
> bindings that BVT Socs support.
> But I'll add another specific compatible string to distinguish it from
> "hisilicon,hi3516cv300-pwm".

There's no use in specifying a generic compatible string if a driver
can't do anything useful with it. If you've only got hisilicon,hibvt-pwm
in the device tree, a driver wouldn't know the target SoC and hence has
no knowledge about the number of channels. Therefore the generic
compatible string is useless.

Thierry

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzUJqAAoJEN0jrNd/PrOhMNcQAJFC/ie5SHOj/qDt4ZwP8Tem
trdJELTwS8Wf4rjHoBnd95PIb4TBS71zY8HFCHnXNPErpNUV1ot+Rna4swLgLT3Z
RHT+z3DiC8ATrs18+iHIdWQ3rQN7X1cueZKn5qLiO50eol5yRLZMDofnVFSczSaV
d3PuFDbytFwIrnN8d9DQP7kYNAdnfpGlYuDv0vXP+8JocUzCLXVIq8T4kuqtEyXI
tk4Z9DBM9RsMuTX3fPUdqVeUnzIaQSAbzYWhd43guNbZIASU3biQav6l3UtYFHKC
fmuZCoGTYVFL3JKRWC+cSwFsq5HI85ElwmkUIb2eVDMcdRBMC2Z31UY2faWRY7lz
Zkwm/V8z8VvLnhpMl90fT7fR71zfZO0Pocp/207/KmfwqkYXygsd1vQRcsb1ceRg
awuoOWaVwIS10u+1Cu1u7+/VYNkfHWU41YVzLSqYrNLLZAOVAB1nscucPs515CjO
ZZTKqDMWuQ3YQ30TAb9XfZDBkmWflE70jiYgqIvCPMmOAZVm30fIpenPIFfqrQCX
YsgkjtDVk6IwtEP7WC/JnGqfddBNdnjE4E7wzYT1V5LVKE8NxeIpjwS/MML+7cNm
R0OfxD10sDDpMkTSSM6NUc/qw/HNNuMz3cISmm1c54rFEuXVogg7eyzAo7E4KoZz
wa0CIToMXB8qJYO7iGFs
=Vxmz
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
