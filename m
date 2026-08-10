Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823FA3A1A3C;
	Mon, 10 Aug 2026 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786352666; cv=none; b=NJQ7sUSe448+o2v8SSg4hFgXpAbPmeZ8hDgoJg/p5U0oHBgVLvgMA1tSHI9QSTGfC0cQODre/xd+c/QPfaY3j8abiyOdmdS0MJ32QEF41fwStsIvpdFJYFiEP+V1FWSqjOlYZlgKm7DA6FF/dFMAj6lp2y37YeY4WbeDt2MBYIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786352666; c=relaxed/simple;
	bh=K5d1O59nEOEPO/soRcDMHsh+k4ZEQlpTwdZuBsFqnCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9g/XTsVjacUhOpeisyZdb2IbJcq51dhTm7iMkMebs9/rpfzXNfHpmvVO85tY3W8XYSdjDWXeqJITYD7SLk2JrTAa7KqFXZ2hD4Sz0l66jtN8YcaJqHHF/OU0ZDGC1i+61XcXLkpgPl1lTj+70j4WYuaZvk1JbvP8vGkA7k2+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoPT0wZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoPT0wZ1"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8E2721F000E9;
	Mon, 10 Aug 2026 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786352665;
	bh=BZs8DVbSNTXuUE6QDryn4MsBKVFgyYlDyYKBoK3LydQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KoPT0wZ1rSYcvHdTBV9T5v6qA0IGB4qIDTGW3y6NVYZMCnOx9eZrBUTX+CvPst7Z5
	 GRDj2ATQtMHmfPBS5vhjoa5E6bgb9VETNSplnO5UqgHu2+C9cjXOZ42LVd9WyX+RDf
	 OhscnSDUNwEkbdcluPWHsf8gJINwLyzzFS/kmpggmqifRXxrlhc3PvzRRXrREcpcwI
	 DuHh+usbtj54r9CBlP2XD+koO2S0seI2b+D2MLQbtMRkC761/lv9r72WWa4xCccQlX
	 kV8197S+tJAGudD9FWJ1zWpZYY4Ff0ENLtMvUaD7r7N0fZtSkb7QgZ9SPoYfXiZfeP
	 BIAR/wYGbs+Bw==
Date: Mon, 10 Aug 2026 11:04:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>, 
	Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: pwm: st,sti-pwm: convert to DT schema
Message-ID: <anmSBVnH82AE1b2Z@monoceros>
References: <20260629-st-pwm-v5-1-a93f2bfec38c@gmail.com>
 <anmK4os44Uz27oR9@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ncknq3ekfe65jlj"
Content-Disposition: inline
In-Reply-To: <anmK4os44Uz27oR9@monoceros>


--4ncknq3ekfe65jlj
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] dt-bindings: pwm: st,sti-pwm: convert to DT schema
MIME-Version: 1.0

Hello,

On Mon, Aug 10, 2026 at 10:32:52AM +0200, Uwe Kleine-K=F6nig wrote:
> > Changes in v3:
> > [...]
> > - Change maintainer to "Lee Jones <lee.jones@linaro.org>".
>=20
> I wonder if Lee has a comment about that. In v2 the maintainer was
>=20
> 	Ajit Pal Singh <ajitpal.singh@st.com>
>=20
> and I don't see Lee agree to be named maintainer. The only rationale I
> can find was
>=20
> 	Also the maintainer email doesn't exist now. I will change that
> 	too with other maintainer.
>=20
> in
> https://lore.kernel.org/all/9379bfdb-9a9c-4fea-924c-6c1dc8e997c1@gmail.co=
m/
> . At some point in the past lee.jones@linaro.org didn't exist either. I
> added that address to the list of recipents to test.

FTR: I got a Delivery Status Notification:

	Final-Recipient: rfc822; lee.jones@linaro.org
	Action: failed
	Status: 5.1.3
	Diagnostic-Code: smtp; The email account that you tried to reach does not =
exist. Please try double-checking the recipient's email address for typos o=
r unnecessary spaces. For more information, go to https://support.google.co=
m/mail/?p=3DNoSuchUser

I marked the patch as "Changes requested" in patchwork accordingly.

Best regards
Uwe

--4ncknq3ekfe65jlj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp5lBQACgkQj4D7WH0S
/k52zAgAjK1Ya4qQ9aQnA5qZILHqeCHaaHbtthbzVKxVjf+jqqWif0dn/N1X60bm
+XN/x9brkeToHiBRNe46UGogMY4lmw1hPCbqndHpL2n3pvhmWYPqtxIL7VsVJC3F
0ZkjmPDVPCYvhbco/0uxBbL+DWkTnzb1uegYXp+dwwhfggfqQrUas9s70IVQZUJG
XO6xCqsM5aVSPP0ZOMROJASFbZSv83pB2QRLko+cQdnIq7KMreIZ4VBtamgPs2Hp
JJy2XSWyvqBRimndOx/B6ZxQ9/zPkNgaXMmhyAWgR/NgEccIyFxxqtvIzcvdD8gk
siwsYvnUEOLwhIaVVIaD8UDPGCDp6Q==
=sEOp
-----END PGP SIGNATURE-----

--4ncknq3ekfe65jlj--
