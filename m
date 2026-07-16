Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3A43DDDB2;
	Thu, 16 Jul 2026 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190355; cv=none; b=Y6s3Sdn82hRStWab06e+x+Jib2debgFPPmKdKkcD21n0a9AAAVZDnDZpUxUWiX/BmKiSVRfdhdqiystRTDL1XpL+04wJgMsvOypCQ2LxfxGpKZsd3rwQYnfKjetNnfP1xKEskQdpP9LcwMgR0/extc6DoADnvuGYESPEimi0nFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190355; c=relaxed/simple;
	bh=Vac98omL0IU2P0EjxSs/zAs81b1yZALyzV32whq5cY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbCu9Sev/nHTyIH5RdlFpoRkD0mostRiPmAA0MclSU1gLaan6XdneJzaSH4HfqjTp7gMb0/2yOXCo1L2d8ue+jzuXcRCDqBuWu5OAim8u0Dq1/60Uk64FKkAqttfSUa/3Gb+vqvhVSkUopc9i/uEm0o89zwI59ub3cdtgmGqXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTq5BKuv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTq5BKuv"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 41FB81F000E9;
	Thu, 16 Jul 2026 08:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784190345;
	bh=379w9bmsYoTb6e7NiRfFGLqmtrfMludoUc8xBnxxPhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hTq5BKuvnTG7AVhoOn4zoR1obr/CXD3ycJyOKUCqoVACmDKUr++tLqVHxp9yzOKC1
	 RcFTD0iHh/UOQljpPSuX3BoHr4XjCvCg87z8sj3PmV7AKGnxkNp+YTs9tG24+RTy8w
	 iSjKr800AyBI3YtRbPlgTo6kCzDTZxz9EHPLr9ETco07n2OGVQaO6ryhyWZjo4/059
	 EpqD9Fe++1AIUx2f0eD74dkKmkSG/6E5hpziJJ3Qiytj2ivcOPKNdzQ035DSdcYCX9
	 66pr9E3jqW7ZNSK0QKFe+l6B3qoTIT6Dn+T3Psi9xURnzaz+xaDDFFVGT/JMCBw0bZ
	 AtpOyJBRzrABw==
Date: Thu, 16 Jul 2026 10:25:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v6 03/11] pwm: rzg2l-gpt: Add support for gpt linking
 with poeg
Message-ID: <aliNlCVK5qrZKPWi@monoceros>
References: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
 <20260604095647.108654-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oh4ecngpkoou75r4"
Content-Disposition: inline
In-Reply-To: <20260604095647.108654-4-biju.das.jz@bp.renesas.com>


--oh4ecngpkoou75r4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 03/11] pwm: rzg2l-gpt: Add support for gpt linking
 with poeg
MIME-Version: 1.0

Hello Biju,

On Thu, Jun 04, 2026 at 10:56:33AM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The General PWM Timer (GPT) is capable of detecting "dead time error
> and short-circuits between output pins" and send Output disable
> request to poeg(Port Output Enable for GPT).

What is a dead time error?

> Add support for linking poeg group with gpt, so that gpt can control
> the output disable function by adding rzg2l_gpt_poeg_init() to parse
> the renesas,poegs device tree property and establish links between POEG
> groups (A=E2=80=93D) and GPT hardware channels (0=E2=80=937). For each va=
lid, enabled
> POEG phandle entry, the driver:
>  - Reads the renesas,poeg-id from the POEG node and validates it against
>    the supported range
>  - Records the GPT=E2=80=93POEG association in a per-chip bitmap (poeg_gp=
t_link)
>  - Configures GTINTAD to route the output disable request to the correct
>    POEG group
>  - Configures GTIOR (OADF/OBDF fields) to set both output pins to
>    high-impedance on an output disable event

For my understanding: If GPT is linked to a POEG, an error detected by
GPT makes the pin High-Z?

> +/*
> + * This function links a POEG group{A,B,C,D} with a GPT channel{0..7} and
> + * configures the pin for output disable.
> + */
> +static int rzg2l_gpt_poeg_init(struct platform_device *pdev,
> +			       struct rzg2l_gpt_chip *rzg2l_gpt)
> +{
> +	const char *poeg_name =3D "renesas,poegs";
> +	struct of_phandle_args of_args;
> +	struct property *poegs;
> +	unsigned int i;
> +	u32 poeg_grp;
> +	u32 bitpos;
> +	int cells;
> +	int ret;
> +
> +	poegs =3D of_find_property(pdev->dev.of_node, poeg_name, NULL);
> +	if (!poegs)
> +		return 0;
> +
> +	cells =3D of_property_count_u32_elems(pdev->dev.of_node, poeg_name);

It's a bit sad that of_find_property() is called twice here. But I
didn't spot a function that implements what
of_property_count_u32_elems() does for a given struct property*.

> +	if (cells < 0)
> +		return cells;
> +
> +	if (cells & 1)

Maybe add a comment here like:

	/* poegs is a list of pairs, so cells must be even */

> +		return -EINVAL;
> +
> +	cells >>=3D 1;

I think a better name for `cells` from here on would be beneficial,
something like `num_poeg_pairs`. For before here the name isn't optimal,
but I don't have a spontanious suggestion here. `len` comes to mind.

> +	for (i =3D 0; i < cells; i++) {
> +		ret =3D of_parse_phandle_with_fixed_args(pdev->dev.of_node,
> +						       poeg_name, 1, i,
> +						       &of_args);
> +		if (ret)
> +			return ret;
> +
> +		if (of_args.args[0] >=3D RZG2L_MAX_HW_CHANNELS) {
> +			dev_err(&pdev->dev, "Invalid channel %u >=3D %u\n",
> +				of_args.args[0], RZG2L_MAX_HW_CHANNELS);

Given that rzg2l_gpt_poeg_init() is called from .probe() only, use
dev_err_probe() here.

> +			goto err_of_node;
> +		}
> +
> +		if (!of_device_is_available(of_args.np)) {
> +			/* It's fine to have a phandle to a non-enabled poeg. */
> +			of_node_put(of_args.np);
> +			continue;
> +		}
> +
> +		if (!of_property_read_u32(of_args.np, "renesas,poeg-id", &poeg_grp)) {
> +			if (poeg_grp > RZG2L_LAST_POEG_GROUP) {
> +				dev_err(&pdev->dev, "Invalid poeg group %u > %u\n",
> +					poeg_grp, RZG2L_LAST_POEG_GROUP);
> +				goto err_of_node;
> +			}
> +
> +			bitpos =3D of_args.args[0] + poeg_grp * RZG2L_MAX_HW_CHANNELS;
> +			set_bit(bitpos, rzg2l_gpt->poeg_gpt_link);
> +
> +			rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTINTAD(of_args.args[0]),
> +					 RZG2L_GTINTAD_GRP_MASK, poeg_grp << 24);
> +
> +			rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(of_args.args[0]),
> +					 RZG2L_GTIOR_OBDF | RZG2L_GTIOR_OADF,
> +					 RZG2L_GTIOR_PIN_DISABLE_SETTING);
> +		}
> +
> +		of_node_put(of_args.np);
> +	}
> +
> +	return 0;
> +
> +err_of_node:
> +	of_node_put(of_args.np);

Would be great if this could be prettified using __free.

> +	return -EINVAL;
> +}
> +
>  static int rzg2l_gpt_probe(struct platform_device *pdev)
>  {
>  	struct rzg2l_gpt_chip *rzg2l_gpt;
> @@ -426,6 +515,10 @@ static int rzg2l_gpt_probe(struct platform_device *p=
dev)
>  	if (rzg2l_gpt->rate_khz * KILO !=3D rate)
>  		return dev_err_probe(dev, -EINVAL, "Rate is not multiple of 1000");
> =20
> +	ret =3D rzg2l_gpt_poeg_init(pdev, rzg2l_gpt);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to link gpt with poeg\n");
> +
>  	mutex_init(&rzg2l_gpt->lock);
> =20
>  	chip->ops =3D &rzg2l_gpt_ops;

Best regards
Uwe

--oh4ecngpkoou75r4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpYlYQACgkQj4D7WH0S
/k56HQgAlmtbr142kZu51xY9wPHqykkBXem4lYob0iqtaJ+3Ylgy4P5x15CpS/s6
an6g6TwcmPw98jaEvOMA3j3hO5Ys7W+h13cdqdy0QrulojILPfB74266Qq+ec7uN
V2gGx73e/VA+XMVm5kMTN64x8V8YafEqiq34M4c8dPzEst9UtpXp+vfErACMeACT
PZGIN1XR3FVBRRcNux9UNgbzSjad8p+H2uIJoj+xRyyIdiyEJ3pyZrs8qi+RSXGS
iZX1rJkN2xUQpG8x1ake+Pb25tUzujg5Ftr+MKv845MRiMKNuMaTLyIrhsuwddlT
jpEUQ7FSnObJWneJ+SHAeXyuS4u5Cg==
=7rkm
-----END PGP SIGNATURE-----

--oh4ecngpkoou75r4--
