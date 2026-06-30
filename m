Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35AE366541;
	Tue, 30 Jun 2026 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841180; cv=none; b=njv5xpshC/cuRJjc8PR0FecR/wZkVWM3SMaRTTeGOsFb4/vk0XkCzXrlmthNba2ESKSJVd6qnx9xqy7CBstSWO8zMNxXqxjn98O9HNiT5IhO4eO2jBu89SQhNtRdYvHy/fR6q2va69N5Cf+04mFYLBZVGU8DIToQ40g/TD5qVj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841180; c=relaxed/simple;
	bh=GVhSEjcUNDWjNrRCPcM8sK039JUB21hjqgUtF6Vyco8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyGOsAvujlY7TaphbBH3tnrEUByyHgZKxvXWxjnznylsv+L22/i0dCwpbI6ymWFpvGvON6KlzJ9TZnt+VBjNtCTIwp5DfQty8zzm4p3e5Wy1kd0J+fNShuXMJd7xAWDiU36PYdPbuhLMdtgKNHScs846LVpLNZGxl9zblbnXiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRBYu/IS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRBYu/IS"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 004331F000E9;
	Tue, 30 Jun 2026 17:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782841179;
	bh=ZSYKIMdaa8r55idhdlD4ARTKtizj6Luf8eogMh4Ab54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QRBYu/ISphMBIeZ86mvArT+CRnur19O0WjXXiSJ6rOrfeV1BmL0qKGj71oqDoZL6s
	 1rjZaEBd73saORKRmmBmn2U5T3omqp1eIcPbthNGJC8RJSF2V/ck/b/JxvSpzhU2TE
	 fePBFa4bO+x1D/af5qd7xAcJUmp2aO3Jj6BRqegaV00UqbW2dJLA+1eDB38JSPEg6m
	 4gcxNK41ZqjKVL6rOQElB6+ptaQDc5zOnAHYF1tghofuW+dBQ9K/vOywwjwLheNsQa
	 KuiO845XZTpnHQCOwKt+tq7Z8tvZK9XwhIzzEci/JXyZl81jSl3sYEG2vJUqyFhTEx
	 r2aybJyysDqWw==
Date: Tue, 30 Jun 2026 19:39:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH v5 0/7] Tegra264 PWM support
Message-ID: <akP-KK1TUFAGXxpk@monoceros>
References: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
 <e7b0d66e-ef2f-47d8-8844-38ae63eaf7fb@nvidia.com>
 <add09636-7b0e-4a99-8503-d98a75c14f4c@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lyf4usywgl62u5tb"
Content-Disposition: inline
In-Reply-To: <add09636-7b0e-4a99-8503-d98a75c14f4c@nvidia.com>


--lyf4usywgl62u5tb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 0/7] Tegra264 PWM support
MIME-Version: 1.0

Hello,

On Tue, Jun 30, 2026 at 02:54:51PM +0100, Jon Hunter wrote:
> On 02/06/2026 10:16, Jon Hunter wrote:
> >=20
> > On 29/05/2026 03:47, Mikko Perttunen wrote:
> > > Hello,
> > >=20
> > > this adds support for the PWM controller on Tegra264. The controller
> > > is similar to previous generations, but the register fields are
> > > widened, the depth is made configurable, and the enable bit moves
> > > to a different spot.
> > >=20
> > > This series adds only basic support with fixed depth -- configurable
> > > depth will come later.
> > >=20
> > > Patch 1 adds device tree bindings for Tegra264 PWM (compatible
> > > =A0=A0 string).
> > >=20
> > > Patch 2 prefixes driver-local macros and static helpers with
> > > =A0=A0 tegra_/TEGRA_ to make their scoping clear.
> > >=20
> > > Patches 3 to 6 contain the PWM driver changes for Tegra264.
> > >=20
> > > Patch 7 adds device tree nodes for the PWM controllers on Tegra264.
> >=20
> > ...
> >=20
> > > Mikko Perttunen (4):
> > > =A0=A0=A0=A0=A0=A0 pwm: tegra: Prefix driver-local macros and functio=
ns
> > > =A0=A0=A0=A0=A0=A0 pwm: tegra: Modify read/write accessors for multi-=
register channel
> > > =A0=A0=A0=A0=A0=A0 pwm: tegra: Parametrize duty and scale field widths
> > > =A0=A0=A0=A0=A0=A0 pwm: tegra: Add support for Tegra264
> > >=20
> > > Thierry Reding (2):
> > > =A0=A0=A0=A0=A0=A0 dt-bindings: pwm: Document Tegra264 controller
> > > =A0=A0=A0=A0=A0=A0 arm64: tegra: Add PWM controllers on Tegra264
> > >=20
> > > Yi-Wei Wang (1):
> > > =A0=A0=A0=A0=A0=A0 pwm: tegra: Avoid hard-coded max clock frequency
> > >=20
> > > =A0 .../bindings/pwm/nvidia,tegra20-pwm.yaml=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0=A0 1 +
> > > =A0 arch/arm64/boot/dts/nvidia/tegra264.dtsi=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0 72 ++++++++++
> > > =A0 drivers/pwm/pwm-tegra.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 155
> > > +++++++++++ +++-------
> > > =A0 3 files changed, 176 insertions(+), 52 deletions(-)
> >=20
> >=20
> > For the series ...
> >=20
> > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> >=20
> > Uwe, if you are OK with the version, we would like to get this into -ne=
xt.
>=20
> This still applies fine on next-20260629 and so unless you have any
> objections could we get this into -next?

I dropped this patch series from my queue due to sashiko's replies. I
just notice these were not sent to the linux-pwm list, otherwise I would
have mentioned it. :-(

So check on either

	https://lore.kernel.org/all/add09636-7b0e-4a99-8503-d98a75c14f4c@nvidia.co=
m/

or

	https://sashiko.dev/#/patchset/20260529-t264-pwm-v5-0-7bf9e405a96a%40nvidi=
a.com

=2E

I only invested a quick glance, but the feedback seems relevant. If you
don't agree, please point out why it's wrong/irrelevant.

Best regards
Uwe

--lyf4usywgl62u5tb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpD/1QACgkQj4D7WH0S
/k5jgwgAkr72tIWgpzv/b+0mePymyvuVqmG86UilwIjrl2ZM3wJM1BynJZbVfWQd
0iDdtbZWMV2WOQzzF/7lAZ0+uAFCu2zHbjc4VHEwsw8RFm1/QxiOpWg58qT3XUX3
9m7U2PEucVXF1hml7RCLfHxsLfjiQRPIwDEi1IJy+hpjW8lROm95eG/SPl7XU2dZ
TOzQKBQ196edIa40cEtlwvgkiTWG9ABv3+R01rCd7AgpUV/8mQItVt8Q2oT0ROiG
ixd18yy/3XqbQuPU34voKC2oIbGQbAbLqQZUGb1rMdUkO+Ii6sP+sdJZdiR5NrKe
b+QeSDXG2Sh4EMJhbCFCC3bRlikdug==
=pRHi
-----END PGP SIGNATURE-----

--lyf4usywgl62u5tb--
