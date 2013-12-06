From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 1/2] PWM: atmel-pwm: add PWM controller driver
Date: Fri, 6 Dec 2013 14:02:28 +0100
Message-ID: <20131206130227.GC30625@ulmo.nvidia.com>
References: <1384766002-2852-1-git-send-email-voice.shen@atmel.com>
 <20131202105957.GD18060@ulmo.nvidia.com>
 <529D4B58.9020700@atmel.com>
 <20131203094326.GB21178@ulmo.nvidia.com>
 <529E9AA2.8020400@atmel.com>
 <20131204100340.GU19943@ulmo.nvidia.com>
 <529FD2C0.6080707@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4263929227164096880=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <529FD2C0.6080707@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bo Shen <voice.shen@atmel.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, galak@codeaurora.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============4263929227164096880==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2013 at 09:11:28AM +0800, Bo Shen wrote:
> Hi Thierry,
>=20
> On 12/04/2013 06:03 PM, Thierry Reding wrote:
> >On Wed, Dec 04, 2013 at 10:59:46AM +0800, Bo Shen wrote:
> >>Hi Thierry,
> >>
> >>On 12/03/2013 05:43 PM, Thierry Reding wrote:
> >>>On Tue, Dec 03, 2013 at 11:09:12AM +0800, Bo Shen wrote:
> >>>>On 12/02/2013 06:59 PM, Thierry Reding wrote:
> >>>>>On Mon, Nov 18, 2013 at 05:13:21PM +0800, Bo Shen wrote:
> >>>[...]
> >>>>>>diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> >>>[...]
> >>>>>>+	/* Calculate the period cycles */
> >>>>>>+	while (div > PWM_MAX_PRD) {
> >>>>>>+		div =3D clk_rate / (1 << pres);
> >>>>>>+		div =3D div * period_ns;
> >>>>>>+		/* 1/Hz =3D 100000000 ns */
> >>>>>
> >>>>>I don't think that comment is needed.
> >>>>
> >>>>This is asked to be added.
> >>>>And, I think keep it and it won't hurt, what do you think?
> >>>
> >>>I think it's obvious that you're converting from nanoseconds because of
> >>>the _ns prefix in period_ns. But if somebody requested this and everyo=
ne
> >>>else thinks it's useful, I'm okay with keeping it.
> >>>
> >>>>>>+	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
> >>>>>>+		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CDTYUPD, dty);
> >>>>>>+	} else {
> >>>>>>+		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CDTY, dty);
> >>>>>>+		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CPRD, prd);
> >>>>>>+	}
> >>>>>>+}
> >>>>>
> >>>>>Neither version 1 nor version 2 seem to be able to change the period
> >>>>>while the channel is enabled. Perhaps that should be checked for in
> >>>>>atmel_pwm_config() and an error (-EBUSY) returned?
> >>>>
> >>>>The period is configured in dt in device tree, or platform data in non
> >>>>device tree. Nowhere will update period. So, not code to update perio=
d.
> >>>>Am I right? If not, please figure out.
> >>>
> >>>The .config() operation allows the period to be specified. Just because
> >>>nobody currently changes it at runtime doesn't mean it can't be done.
> >>>
> >>>It is also possible that whoever wrote the device tree or platform data
> >>>didn't know that the period must be the same for all PWM channels and
> >>>therefore might use different values. If you check for this, at least
> >>>they'll notice. If you don't check for it, then they may end up having
> >>>the period reconfigured behind their backs, which may cause parts of
> >>>their setup to behave unexpectedly.
> >>
> >>Thanks for this information.
> >>I will add code for changing period.
> >
> >Just to clarify: I wouldn't want this code to allow changing the period
> >but rather reject incompatible changes to the period with an error code.
>=20
> So, in this patch, just check it as you suggested in previous email, would
> it be OK?
> --->8---
> Perhaps that should be checked for in atmel_pwm_config() and an error
> (-EBUSY) returned?
> ---8<---

Yes. If a user tries to set a period that conflicts with a previously
set period (by another PWM channel), then pwm_config() for the second
user should fail.

Thierry

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSocrjAAoJEN0jrNd/PrOhmJAP/jLz989hIjFkq4oR4J61qPOq
6RClj+GVvJcIqqKb7PTCYrvRYYXgR9i0XOiUOA6U7sh5Hf6uD7uj3fFz97F80X1B
mtzMQYC4n/MDZKgXOsK3ZNTI6tcXaq1+BQeq+HS61EFJDkD7wlfDRlNhn5svCfgZ
72V0+pDxth81JyIL5jib+8o5zBN8PvvUV5jvgXBYo1CL9dfJJPMPtGM64C4Lclp0
2Xq2ZRblRuxNF7nYVyT8Yu1Q6tXq7k41nwNeMDrxf8EZzjTLIZn5CG+H9LXFkMZ+
WdbpIRDyzBurk1j1annSgiTepsk/aMd2R/aNtE2A9Zv1etU7+xWhPhT+ngfYD7hZ
Yr7ee31h5bDF3atOdfIwTY6Jfebbuh382zs6d5sYm1vAbgckJMMP1WX1CAdwHtME
8nmjEvXXO2ZdQaPP6CdsXZnVGtt6UyXeLynf8eLtL5MNPPOCLRQ3QwzKi0quIvHI
9eHgWgvVXZEUQw2aVtSlUNi4/AMRTBVrgMlENn2BcYFzY3+Q6FcxpNdBVKjyzCiZ
O7aWRpIv+++VDa/LKYotr0At9Ts2ZyCiDHEA+ZflYTPQowUvf/i4WzO+AkUdmmUD
DEAfhCmRS0MVEa8vyKQ2ty7kV73Cse+SQzEJ60LCiCqjJErhdQ/1pjREEDo6RCPo
RT3IwETmwDRCYmj1N3JC
=NhVV
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--


--===============4263929227164096880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4263929227164096880==--
