Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C62F7EE1;
	Fri, 16 Oct 2026 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146788; cv=none; b=QUAKo/m6CgtyxamKwwpWuobWs07KBwPVlRqJhCD4YtEY+tOvkQoXd0JF6AboUNNN5pFIrws1ygGA46+WZmRwEo9WtXJF1UERqFpzQrsBq+WZCDGed6fKfCQeQQDWURgT+Ej6+3PByTdmNpNRRp+GyVw3R63vmuQVe82FckPGmwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146788; c=relaxed/simple;
	bh=OADrCI/YO/DVM6Vcz+CdVSJ7cnm3pZP4UYHcSesLMNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ8dt/0b5Pe82kRoWz+PyvleRSxmXqA+KECpcx6EPyxJwyO496TT25MQc6OqA+Rx8zZIfwSB5OxJbD1OKDgsLQumJcF+QUHV+I05i+ndvRfTa6t7h8mwunNSlaRkkkiO7Er99YP+dvqA+Xwg9EJC8MEa7DcAN1DxGa1A/KlfnXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akWohX9l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akWohX9l"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6426B1F000C4;
	Fri, 16 Oct 2026 10:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146786;
	bh=ORDk+z99WdoH+a5HHmZdVeJEPqWIuYJXwdqLLiZ3fRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=akWohX9ljFjYmPnINudJZSCOHmZkxubvZY6aj6cPg8y7AiO3saG3Du13pZQ6FLqvb
	 4doswBha8UCbgTFqxBQOrNK82A8uQN5ynZXcktNSn9IwlkEOufKEnY+2uWCr5oIVmD
	 gQASP1rvyBUsmReHOLR9j5Fs8mrIqIXxJy7O7q33qkUeOcWd4TWNYpHjS8aALFl91K
	 Z1Y0ofuQoJ0qQ77XM1ZkA+vQsCLdVCa0LQHVlX14QZf41+fF/tmgdxXzC8llFQEqRB
	 9EJSLvtrYI0njv5EenQQ97itlc6FzChHcRGNXQ350HZE713c+IxTFZMMKBF0U2vdTN
	 fN5SFvVy7TrEA==
Date: Fri, 16 Oct 2026 12:33:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jeremy Dean Clifton <deaner92@yahoo.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: pwm: Convert NXP PCA9685 PWM controller
 to DT schema
Message-ID: <atH835VJLqo_mdjY@monoceros>
References: <20261012140346.3065-1-deaner92.ref@yahoo.com>
 <20261012140346.3065-1-deaner92@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p26ye5edjmfu2wbm"
Content-Disposition: inline
In-Reply-To: <20261012140346.3065-1-deaner92@yahoo.com>


--p26ye5edjmfu2wbm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3] dt-bindings: pwm: Convert NXP PCA9685 PWM controller
 to DT schema
MIME-Version: 1.0

Hello Jeremy,

On Mon, Oct 12, 2026 at 02:03:46PM +0000, Jeremy Dean Clifton wrote:
> +maintainers:
> +  - Jeremy Dean Clifton <deaner92@yahoo.com>

What kind of commitment do you plan for this maintainer role? Do you
have the hardware?

Best regards
Uwe

--p26ye5edjmfu2wbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrR/V4ACgkQj4D7WH0S
/k4fJAgAiKt4nDUU6gJFL3M+DWiXWioiYyD+Abhb+tkLeqMMpDpGY6RpAPmVwdHx
UYM8KRykOKrW9MWgE74ltOuDhEyzCzWxO0a0DfHRRjsuzcdf3JUUxnXI+NC4g7Ei
o+qkIIV9la5xmadu31IAovMTO4+4cL2T5S93h9alCjt6IYIn99rRYRQRmv0wb1vE
SYP3RsCV58u1F4zWSoW1f1RldC5ikPZkReY7Z+R2/FRqPohdrktc4BniSQHEq1Ea
BYyWSaGMjBKu9Fy9VTpaZYwNsRkylCew5m0CgMaKHcRF6vgZZevFPPNvHevcGMOc
c9yy4SLrFwnisxaB3dM7x+FUfqoVbQ==
=gVyh
-----END PGP SIGNATURE-----

--p26ye5edjmfu2wbm--
