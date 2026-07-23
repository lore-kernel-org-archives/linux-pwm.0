Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB03A4F51;
	Thu, 23 Jul 2026 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787011; cv=none; b=MHU0gCjvvoOzthBx9Unut4X2QbL93zPFzZJ5vGscWQTRh0j7sqxyd29CxxVWG+0SAZNg6Nz6CQzRHEwVZowxxQIOTpDR8m073ZvFLqSaTN80HohBNhPusivn9RPxIvcr7Qo3H97ND03tnHB496C6QYSQ7mq4zyPjVlYdARR8R9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787011; c=relaxed/simple;
	bh=WhdBv1DD+mg8/k0SjVnmTU+YiCvCDK2j13HmKpzYk4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORw8XovwQOU4bW3ZGudb7dAB7K6/EfNms0bdui8dc3O/T7oRia7KzgRJpm5uVBX6iOh0cAA9/A7sq2ofF21R6gSsk5dZqFr7FltYtidJAwDveCw0T4kKcrgnwLCqvHiTLQaV8VjKr/c39jEXVEaOJvLhX8ld0z2WCT1eg4BYgVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RerGSwqV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RerGSwqV"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4A4D21F000E9;
	Thu, 23 Jul 2026 06:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784787009;
	bh=WhdBv1DD+mg8/k0SjVnmTU+YiCvCDK2j13HmKpzYk4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RerGSwqV8+JnsPhEugS7MoSqBzg2xH4sSz1Uw3XCOePOpKaGvz/lP4t+ZXHPC93SA
	 7D+BGiD56Hgf/sCPeZOVQ5MzihhBo2/Tcb0KKZ5rTly91FqNLUJ4shWH+lcVSTC46w
	 KBfZ7q+qGMrJeGJyhBoKRNbdFdmKxTPqNLxMGg1mNrPw3SSPvFchdpDysmnPfmqqyd
	 9PZ6CEywwF+4WBCyhjAVsKiZWW/oputlml4M15qUg7Ba0287qu8UW8K/j6XSYU2zY0
	 q/fq308ylzykregTrmKcOaLiJUu5XRK5ilvMh0PFquXhZQ/nU/nOpN3SWFkXlIpbiv
	 ONyeT0lcrv0rA==
Date: Thu, 23 Jul 2026 08:10:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Darrick J. Wong" <djwong@us.ibm.com>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: hwmon: add binding for adi,adt7470
Message-ID: <amGvR3VwfDN1Gi0Q@monoceros>
References: <20260717-adt7470_thermalzone-v2-0-a55147958fad@gmail.com>
 <20260717-adt7470_thermalzone-v2-1-a55147958fad@gmail.com>
 <20260720-placid-fanatic-shrimp-d2bcd2@quoll>
 <a8fba49c-bb72-4b3b-b598-4972304e0b4c@roeck-us.net>
 <CAJq09z6qQnKXgBnQKCey4u47hsJTjpYXPDvDZj76sXHZuj2emQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cll6tmmlhnoabstr"
Content-Disposition: inline
In-Reply-To: <CAJq09z6qQnKXgBnQKCey4u47hsJTjpYXPDvDZj76sXHZuj2emQ@mail.gmail.com>


--cll6tmmlhnoabstr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 1/6] dt-bindings: hwmon: add binding for adi,adt7470
MIME-Version: 1.0

Hi Luiz,

On Mon, Jul 20, 2026 at 11:12:49PM -0300, Luiz Angelo Daros de Luca wrote:
> Initially, I modeled the driver purely as a cooling device. However,
> following Sashiko-dev's suggestion in a previous review, I converted
> it to expose PWM channels so it could be used with the generic pwm-fan
> driver (which indeed makes the code cleaner). My primary experience is
> with DSA switches, so hwmon is a new area for me.

I like the driver exposing a generic PWM. For me it's quite in line with
the "Linux spirit" to do things with devices that are possible even if
that doesn't figure in the vendor's scheme.

> Whatever you and the DT maintainers agree on, I will gladly adjust for v3.

But my opinion doesn't count ... :-)

Best regards
Uwe

--cll6tmmlhnoabstr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmphsDwACgkQj4D7WH0S
/k7lqwf/Xq1hrcclNjopIUHYjq/ZmsRHMQe7JInwuovR5K1IvCOWdwrNpO1kvf34
MBP6lKRJPnSHpti2MrCXjqjaapLM2p55UQkLv2VYa4tYPHYnFYo4XAMFIYlSFJJI
9Im1yTxJmDM/jdk/taH6fimsu2ZOa9WLbz/2odo0XPVp/CeZqDyNofFGBDj8vmHC
Du66lLvLGRfbSUwv5flPopsJwL83jgiDzx/wDWadW6+M3oUVKh2LUIkjOjz6tthH
Wv2rEHQWRWZmf4cKJTOk69/VDovOtpelthr+1mZhkBmd/LYXID4O/ULmeUPg/GcP
ob+Uxidpj3bmhTls6SZK4u0gs5lZgg==
=PJzl
-----END PGP SIGNATURE-----

--cll6tmmlhnoabstr--
