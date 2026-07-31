Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5E03090C2;
	Fri, 31 Jul 2026 05:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476371; cv=none; b=QKaQJAWsGvClniXI4kssP9K/OHTQBYbe5DLOYsXGvx5495abOT1KsX3PdfQ7ErTpl4OiHQpgRZhmoqVhjMUgvN2uCRM7TJ7F4h9dHAIekmT76xRb3GigDvm9XqJXY5sgzF9Aa3YWJnICZzlarifPbLctn8JXdeVrub9pH1JFrIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476371; c=relaxed/simple;
	bh=imXFAqWPqnJGY8WW24n+T9ijDhVhtqz1JOrVbz5WW8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq0rYDh4qBNj6FInmgZyer3xtE/kSBmwiasIARYvO4ahy5zytNxVCjZQKlFm45hjJGi9AXHmLJXx0Gu/GbAueXFxY00wCuoo+7nl7L83yzZZspryLzh1gHetoyLdmrukJwPR3/kdj+Az3rcFVmFdLmFXkP6oLP4jO+ZDeMsStYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ij73W4jw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij73W4jw"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 984031F000E9;
	Fri, 31 Jul 2026 05:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785476370;
	bh=nl9RKaJgoDPBj/kQI6IVDW+vPVyPl1iFcSZlkgXadKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ij73W4jwXtp193BFt5tTx4ziblgpB9RWjgDaUSGDUsFuwBmivMwIF6N/yYJY2BChw
	 6OCPc1/PF1reat/oZuzkbfajvMr06/zDsmmcvnVJKafigMVrGdgHEENTM91IUA5odc
	 1jt2wgterPuTUjaTC2VrhvFkXSpOwFbdy7x6oM1qfe4hW5zCelW/f84vsre64/bEa/
	 40IJIMfZMkB3/VnayJQ4lGPVx1XR89qCE+6CIAd28++EANROMr4FFIQIdCc796F2G6
	 zJR4NTC75jCPi/CgjvoJ/6GTYorduZKLD5e6Z+ktX9fHC80dn8+aMow9ZIe79kpNMY
	 U+Di/YGCqnThg==
Date: Fri, 31 Jul 2026 07:39:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Darrick J. Wong" <djwong@us.ibm.com>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [hwmon-next PATCH v3 1/4] dt-bindings: hwmon: adi,adt7470
Message-ID: <amwnEYMPhWXC3QJO@monoceros>
References: <20260728-adt7470_thermalzone-v3-0-d4586478cdba@gmail.com>
 <20260728-adt7470_thermalzone-v3-1-d4586478cdba@gmail.com>
 <20260728-meteoric-quixotic-sunfish-0de2cb@quoll>
 <CAJq09z5CQgzzFahoiteh9ykjdbsYpP=QZ2AugzY4tQ79RpA-cg@mail.gmail.com>
 <6cc03c4c-2d88-46f2-aee4-adb769d10cbd@kernel.org>
 <05b7f116-25a9-49b3-a31c-15eb4e6ec838@roeck-us.net>
 <CAJq09z5GL16qQ6smjEHsiYxpXn6MaBkibwsvSR66cJ4kEx1M6Q@mail.gmail.com>
 <a447e67e-ac2c-4b8c-bb96-b469d2a2d61a@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fobe3on45uuvhdwt"
Content-Disposition: inline
In-Reply-To: <a447e67e-ac2c-4b8c-bb96-b469d2a2d61a@roeck-us.net>


--fobe3on45uuvhdwt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [hwmon-next PATCH v3 1/4] dt-bindings: hwmon: adi,adt7470
MIME-Version: 1.0

Hello Guenter,

On Thu, Jul 30, 2026 at 02:37:01PM -0700, Guenter Roeck wrote:
> On 7/30/26 14:11, Luiz Angelo Daros de Luca wrote:
> the architecture, while I looked at the `emc2305` approach,
> > delegating the actual fan management to the time-proven `pwm-fan`
> > driver allows us to avoid reinventing the wheel (like cooling device
> > registration and state management) inside the adt7470 driver. It also
> > keeps the standard PWM consumer/provider relationship clear in the DT.
> > It still feels strange that emc2305 declares #pwm-cells and its
> > subdriver fans pwm properties and they do not work as a pwm
> > controller. Other drivers, like aspeed-g6-pwm-tach (with similar
>=20
> That is your opinion. #pwm-cells and pwms exists because it is mandated
> by DT maintainers for configuring pwm properties. That does not have to
> reflect the implementation: DT property guidance explicitly states
> that properties must describe the hardware, not the implementation.
> There is no mandate how to implement a specific driver (such as a fan
> controller driver) because a specific binding exists. It is perfectly
> valid to describe pwm properties of a fan controller using #pwm-cells
> and pwms without modeling it as pwm controller (which actually mandates
> support of the pwm subsystem or no good reason other than "because").
>=20
> While you may consider the emc2305 approach inferior, I happen to
> disagree. That is your personal opinion. For my part I consider it
> inferior and overly complex having to involve another subsystem (pwm)
> and another driver (pwm-fan) just to make the chip's pwm outputs
> visible to the thermal subsystem as cooling devices.

Strange how opinions can differ. I'm with Luiz here. While I agree
that mixing subsystems is slightly inconvenient, hwmon uses i2c and spi
and clk and regmap and probably more, but pwm is a problem?

What you call "inferior and overly complex" is actually nice and elegant
in my view. There is code that handles PWMs, and by not using it you add
code duplication with all the downsides that comes with it (different
behaviours, maintenance overhead, wrong expectations).

So amc6821 and nct7363 only support #pwm-cells =3D <2> which is
non-standard for PWMs and I don't see where the period (cell 1 for
amc6821 and cell 2 for nct7363 *sigh*) is going into the driver.

For emc2305 uses #pwm-cells =3D <3> but cell 2 specifies something that
actually belongs to pinctrl and not pwm, and cell 0 is a frequency
instead of a time. And interpretation of cell 1 should better be done
using:

diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index eef3b021671b..c704fcd61356 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -571,12 +571,8 @@ static int emc2305_of_parse_pwm_child(struct device *d=
ev,
 	}
=20
 	if (args.args_count > 1) {
-		if (args.args[1] =3D=3D PWM_POLARITY_NORMAL || args.args[1] =3D=3D PWM_P=
OLARITY_INVERSED)
-			data->pwm_polarity_mask |=3D args.args[1] << ch;
-		else
-			dev_err(dev, "Wrong PWM polarity config provided: %d\n", args.args[0]);
-	} else {
-		data->pwm_polarity_mask |=3D PWM_POLARITY_NORMAL << ch;
+		if (args.args[1] & PWM_POLARITY_INVERTED)
+			data->pwm_polarity_mask |=3D 1 << ch;
 	}
=20
 	if (args.args_count > 2) {

(Yes, I agree that the difference between PWM_POLARITY_INVERSED and
PWM_POLARITY_INVERTED is annoying.)

And all of these seem to ignore the phandle.

So these all only somewhat look like standard pwm bindings, but actually
there are traps and surprises hidden for the device tree author.

Best regards
Uwe

--fobe3on45uuvhdwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpsNQwACgkQj4D7WH0S
/k67bQf9GkgUqIbm3L9Eok5H9+WZQpFGDmrqMi2VBeJAHzcF+mG8N5/2kzf5BUXh
L0ZeyccX6EBuHTOsI1Azgu2J5nWy/rYaDxNPbfpmR6atxaffmd8xLa454vZCPD4C
0rrxdk8/kGM7n+C9L9XxMmpnQ0Hozb/t78L8EQX83/U8gQrPcgB/xJc2LCdJd5qK
RzXHd0Tm+I6J+UAbuRLLpd4kh4qCTi9s1ayhFUu/jnYbJSWkUB8vcOukDwP9MsTM
/W2bJ235ML+swt0NaSC1P64+NzLkUV1nMxwMyy6CbQOgAzcOpglzSUZA0YX2EFTy
Zw+0voTiekDy5SvI3EVMLrzXc0umYA==
=WUsj
-----END PGP SIGNATURE-----

--fobe3on45uuvhdwt--
