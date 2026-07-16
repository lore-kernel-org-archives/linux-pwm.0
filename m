Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432AD233928
	for <linux-pwm@vger.kernel.org>; Thu, 16 Jul 2026 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188211; cv=none; b=JNXjMtRm6coAsWzhaUrylShMpDAJ0QcY5tjILOv6VxP1Z8xrnqF/jSskdtN6BC1/35GHo8oXE5+8ncYuGupp6t3HjjKZ8h+3CTbWGQewwqGTKI2OhiDvNmJGy9rrk0TOYAb24Bp4Y3IH4B+7IWZXwwTHh/7ayXLI/ZHxDCjjPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188211; c=relaxed/simple;
	bh=WSm5DvyF8kAHJUVbVgOYyfVr+aqNLZrjwo3Xgdhidzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFCHk9aMSZZxSofgLWzJmFWxs5nXnsZhRXuDhpsTV45ebuff0HTwVNZW5Rj17Gl2Y8fuHuL/Pbwj3eKYL3m0dXcRKgOpoF4zYMRJSs81SuAsbJxlK4+EPyJuV7TVKdt5hu2JOEuAkv98tXqZ/ANafGGcGEfVF4TUKFfja0jdIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Lupt5wgq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Lupt5wgq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so19663855e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 16 Jul 2026 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784188207; x=1784793007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZHFPco7TSnfWS2raS1ySQoxI4o7bq53nli6SfJ3sWqE=;
        b=Lupt5wgqOQvVXWvd2Tdh+ciVGVTBVLlXkM7BhuziIwPl6prGNDAs2gVg5zXet1/ypY
         qIKoo98MSCbfcRXEtD7Ov3lWrExsU80ToDdj11EgLoI3PZL7An2kZWU/frfPGB/Zm6Q0
         l9liFOwLhMbN7NjRacXN+Fpd1IwDLgEfFCwf5dTbNNPDkTI4/7UrneTXo8FE9uBFhivR
         5HLmaX5GYKF+LfmbZZ8bmVorbmG08XxKlpDCqCV2efST3r7n162ZH9Q5vOSK1441l6/H
         /IAd41Ovk8M5C31EV48rljCyufHEDpNwqBe/6ojCxGXioMDZy5OyjGVfkg5O/0Iub3Er
         +K2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784188207; x=1784793007;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZHFPco7TSnfWS2raS1ySQoxI4o7bq53nli6SfJ3sWqE=;
        b=mTGjUcGmLTjPHPVEa8L8VrZjq1EnPeHsqqA+jxy5AHxIItxyl0FmyaauBsVfnOJCoy
         ufYAMDRkT04wIWXO34MVT1znMj47YtxPmNDo4YZdXqGrEaDBHZdJ33vAlk48fYlgcW6y
         OEPi7xN+jWgwWGv5wFDCOgaCR9WKjzhrFaRDh9JHYhA52PKnUrrS9aW4nL4xWEHnWjG+
         PIWnAlQVZrTlQKEzFNvmppUZF6z1qKiEMmVLhQxBEKddOlNzEaKzcKRPk2RMbxBJTNig
         fGQjDnWP8DuZgHFqU1RUxtLMT3wT84A9iyKuO1X1u4HLrpnHmoq4cfy9lKLAfFf+Z53U
         /DIg==
X-Forwarded-Encrypted: i=1; AHgh+Rp7NEaFuUD3Y1R7Nls5P57iSiakgAzWxae2C4NlffoV38JJRdfhq1UoSRIsX790KIl0j5cqVb/O7x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwXDtsi0SdyvfLxEkMcU9GQufOcVlWni+9YVVSxvDVEKowYve7
	9ciwumRBOWzmhROSjfeM5KB55+iH2ZOhSHrn8dF4j5hxsCVkuydomEgTof2JFANi4dUhk3bv7gB
	ORZ2C
X-Gm-Gg: AfdE7cmIY9ZHEvHcR1BctZaFlP9m3cZt5PIN13bCG89VIMHiAblcy0SV3JFmobFw4g7
	lTqrDKBUa3otYONtp9f03Y2MthbVvNoGVSjyhbG1r3vfuzKe6w817OiA6DZ5OfuGgkmAKcd6iwS
	HOsxFQ4xQ7DSd67u4Yxivg19fPm1WfWILhAWd7S+FQwsTZ3jJTmVGzw8elM8zEo1ao8hdGRRAd5
	fpCQ0IS3XVZYPnaHpwfsq1f3nHXosgRd17oJN4WVuSq7LLptQDzJKKAiDnWptP70Cen3oXStDYZ
	n92jqXJ/n3ye9uPXT37MPIjC2uVhy1ky3BHmkk4BRqEWbX/ZyO9vVbjb1bKoQ5IR6HfrU16pbSt
	9FNVdkndaQzUhiVf5xoxtCYEnWrJEIEgLm4MId1t4EOVmqAN6TesYRuR0EIP/YjK+NICw/xWvNB
	NomvALReMDaUUqElKEVb7tCfI5nSSUX86jnZYSuDgOn5yYwu9z+0RdwUYQqnizo3fjXg==
X-Received: by 2002:a05:600c:a03:b0:495:4572:21af with SMTP id 5b1f17b1804b1-4954572224dmr31265e9.9.1784188207461;
        Thu, 16 Jul 2026 00:50:07 -0700 (PDT)
Received: from localhost (p200300f65f47db046a548a0537ec1e67.dip0.t-ipconnect.de. [2003:f6:5f47:db04:6a54:8a05:37ec:1e67])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49541e53680sm35386345e9.0.2026.07.16.00.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 00:50:06 -0700 (PDT)
Date: Thu, 16 Jul 2026 09:50:05 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: sashiko-reviews@lists.linux.dev, robh@kernel.org
Cc: Biju <biju.das.au@gmail.com>, wsa+renesas@sang-engineering.com, 
	robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 02/11] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
Message-ID: <aliM3iVA1LY7tW38@monoceros>
References: <20260604095647.108654-3-biju.das.jz@bp.renesas.com>
 <20260604100619.75EC51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dlfpmfyr2hw5fshj"
Content-Disposition: inline
In-Reply-To: <20260604100619.75EC51F00893@smtp.kernel.org>


--dlfpmfyr2hw5fshj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 02/11] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
MIME-Version: 1.0

Hello Rob,

On Thu, Jun 04, 2026 at 10:06:19AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The `renesas,poegs` property improperly encodes the consumer's=
 channel index as a phandle specifier, which is a Devicetree anti-pattern a=
nd breaks standard phandle-array parsing semantics.
> --
>=20
> commit 9d7f9847d3f320fb715022b6159c9c7e869aeedd
> Author: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
>=20
> RZ/G2L GPT IP supports output pin disable function by dead time
> error and detecting short-circuits between output pins.
> Add documentation for the optional property renesas,poegs to
> link a pair of GPT IOs with POEG.
>=20
> > diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.ya=
ml b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> > --- a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
>=20
> [ ... ]
>=20
> > @@ -245,6 +245,28 @@ properties:
> >    resets:
> >      maxItems: 1
> > =20
> > +  renesas,poegs:
> > +    minItems: 1
> > +    maxItems: 8
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      items:
> > +        - description: phandle to POEG instance that serves the output=
 disable
> > +        - enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
> > +          description: |
> > +            An index identifying pair of GPT channels.
>=20
> [Severity: Medium]
> Does this property correctly follow standard Devicetree phandle semantics?
>=20
> By Devicetree specification, phandle arguments in a phandle-array are
> defined and interpreted by the target provider node, with their length
> dictated by a cell-count property on the provider.
>=20
> This definition appears to invert that model by using the specifier to en=
code
> the consumer's (GPT) own channel index rather than a provider argument.
>=20
> Additionally, standard OS-agnostic DT parsers might fail to resolve this
> because the referenced provider binding (renesas,rzg2l-poeg.yaml) enforces
> additionalProperties: false and natively lacks a #poeg-cells property to
> dictate the specifier length.
>=20
> Is it possible to redesign this binding so it doesn't encode the consumer=
's
> index into the provider's phandle argument, or at least ensure the POEG
> provider specifies a #poeg-cells property?

You acked the patch. Is that review concern by Sashiko valid?

Best regards
Uwe

--dlfpmfyr2hw5fshj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpYjSoACgkQj4D7WH0S
/k6tuwgAoYXQ694Z1W43wtbN4Q8kTFE8ndqpCfHlpuCbB0NRKCtNaHfMKk1OPa4/
0gPb9j+93rmTvlexpk6MtwSdwO+elEB7SbAsXmIFnybR+b3ciwZr+5LmGMRKBsw2
xorhAlS2ouIZjnTYBDcmaXZB1mpodWWYzDvRdimGK9+eX+DH2lPtNCJ6g9wRtOvl
F+YM1zXNuwWAxLoB6s2pfw83iG2CMLowNj4/q4rfmgFUHlWk0wOR2iDHDJDQbusJ
e/rANSqVjpOz2hIl/Dz/+gJpUPQKph6siwen5swjqmVtIkTBW8L3YYc7RIhBkVA+
J7364EUYQSEfnSx+nNBE/CnQWmhMgQ==
=SEOL
-----END PGP SIGNATURE-----

--dlfpmfyr2hw5fshj--
