Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55185317164;
	Tue, 30 Jun 2026 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813578; cv=none; b=UFet9wToJBRDrHxt/KBMsHFtVJ3Jc0omwuE2seak4+VgSbRvHki/6xG979QiZhpkPXE8ASlAI2nk0fZGkr0sMOnqN/22+0N23ExLakcKOsUuvABhzAiriEOh9FJyww/BjByIH2o55BJxXzzuMmM2QI3dX+81g79MxUpe/3U+RCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813578; c=relaxed/simple;
	bh=9HR80y+uE7bIR4bZjVORkXp36/uTWSKCANgLeVCUwcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu753kZiLTzqPSP+r3/iEiuVljw04HYKprIDwg1bdXqfH2dR1NmeazJVRdkwPi2xae2cJePTYJ8txI2g2UEJL/rBPOQyt3RCh2tysZivlxUSBVs6CxtZGluGmv73EmwzRAgYqU6pWD1Cf8N5e1zEeIMbZ6r1Gb3cUJ5mG/ahaBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ez+Zzv/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ez+Zzv/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8609D1F000E9;
	Tue, 30 Jun 2026 09:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782813577;
	bh=9HR80y+uE7bIR4bZjVORkXp36/uTWSKCANgLeVCUwcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ez+Zzv/rHixTDU9gexxUTS698bwowOyMBM+JBX6OjvBL6C//6Bj4+Yume51fzGFvp
	 iUx8EuPt6BwTdRdi8eudfMaGoGI7tbwvSg8sbKRvmeT2HQs0Oqv4mBj4Vcl6JUSqam
	 H+kzp0Y3k92jQ3JBJGuhUTBfPRlwghgyJJDb2XeE+iP1VbAkuwnADIKSjJjs8iIAii
	 0J7B7TcnOXdXdsUGao/RRCSj4dzq4xTeHHvmfNDoNWeKXCx25qff0NARydJqw6pMUz
	 oLCtRgT6WogFsTclYFRcCv4FKqSAidNvLX6CFMFzmngxx/GIdJy0CoSBagNR8zmKWD
	 y1XzwW+uI/K5w==
Date: Tue, 30 Jun 2026 10:59:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v20 1/3] dt-bindings: pwm: opencores: Update compatibles,
 examples and maintainers
Message-ID: <20260630-footpad-barbed-2415fb3acd5c@spud>
References: <20260629063601.63917-1-hal.feng@starfivetech.com>
 <20260629063601.63917-2-hal.feng@starfivetech.com>
 <20260629-unedited-tarmac-b6eaaaced8fc@spud>
 <ZQ2PR01MB130775F6E674F6074A6E2CA9E6F72@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zxIQn28rhvHzrlL0"
Content-Disposition: inline
In-Reply-To: <ZQ2PR01MB130775F6E674F6074A6E2CA9E6F72@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>

--zxIQn28rhvHzrlL0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 01:15:09AM +0000, Hal Feng wrote:
> > On 26.06.29 23:00, Conor Dooley wrote:
> > On Mon, Jun 29, 2026 at 02:35:59PM +0800, Hal Feng wrote:
> > > Remove the jh8100 compatible since the JH8100 SoC has been canceled
> > > and will not be released. Add the jhb100 compatible to replace it.
> > >
> > > Change the register size in examples to 0x10, since an OpenCores PTC
> > > IP has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.
> >=20
> > Actually, please also add a fixes tag to the original commit adding the=
 binding.
>=20
> OK. Will add it in the next version. Thanks.

If this version is up to scratch on the driver front, providing one in a
reply here will probably suffice.

--zxIQn28rhvHzrlL0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakOThAAKCRB4tDGHoIJi
0pGDAP0V84v0E0JF11z4iKvk1U9IU4AGvM9YLUuWPTFAiaNNBwD7BJTuPKX9SsUT
AMmioCQOnL6t08Nvm8frfHvjzxL7VwQ=
=konP
-----END PGP SIGNATURE-----

--zxIQn28rhvHzrlL0--
