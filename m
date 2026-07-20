Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1A939901A;
	Mon, 20 Jul 2026 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541812; cv=none; b=dGhPa+N2OJOrAV2kRrxEzt4ABzZx/2z5Ui1du3yLYQ/b2JHtZox2gOJcWMPTHrn1GGjdaxKaQLZiQ24S9J7fhkaAwzwApnrX9V6FqxcFqcGQ5+XchetTTWunq+ySUstOhnuoLUFxrxc7Wmr7xLHh7/ZoVi453by1GOty3ylKfkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541812; c=relaxed/simple;
	bh=SUqgHFkKO0otM9yI+YUomW64xWTx+HL33jVEFIAJXe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekjscTXzhCii89ddRT8CGh0iiL70XgHPvtqeeyEnUg4jeBSj1fYWlFyhs4lBPEanRbRX+GmIo8c3iB5UCVHTpfzM1+9ujlfebS0mmL93so2BT/ZwahtMWMsw86qXki7fVCBelakxaGPZKX5xcNv5+O0Xpf88/1hJhyQqg6lHXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnNJMP6/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnNJMP6/"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 25CF51F000E9;
	Mon, 20 Jul 2026 10:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784541809;
	bh=JGPa/uH4JwInJPPVmlE6Tl4biqGXrEgmLdXgjle6m9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TnNJMP6/C6P6hNiqm/DmghD3koz96HOX7tp7/ch/exg7HfoLJhahwaBAhsSP2p4bn
	 L03Ix2q9RWhSCMHFbSKi4ACv9bsdciSQjM6NloITdIFGF9R7dZWgN+h3koIhMUqaFk
	 jRSB5pffj93R+UrhZTCd4pEpUKtyCjYeqH/c0JyPoWTWGtANdah0MMYwq9fS9Me+q5
	 SYjiQpFuHdki2nMJJzUXwvQ1XIKsOOvx6TN6z8ihI+b3In5q0r9XIS4c5XeBVXj7pZ
	 Gb5QTxXd4JbRekYz5efHfdHsKLolCFCMKg9LS3ziRSsUmThwy7tOvyFW5F/3puxND+
	 aHVQ6k4YLW0zA==
Date: Mon, 20 Jul 2026 12:03:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Darrick J. Wong" <djwong@us.ibm.com>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: hwmon: add binding for adi,adt7470
Message-ID: <al3yFHvlzQuIywEj@monoceros>
References: <20260717-adt7470_thermalzone-v2-0-a55147958fad@gmail.com>
 <20260717-adt7470_thermalzone-v2-1-a55147958fad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d734jrlis5p4zo7z"
Content-Disposition: inline
In-Reply-To: <20260717-adt7470_thermalzone-v2-1-a55147958fad@gmail.com>


--d734jrlis5p4zo7z
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 1/6] dt-bindings: hwmon: add binding for adi,adt7470
MIME-Version: 1.0

Hello,

On Fri, Jul 17, 2026 at 05:59:14PM -0300, Luiz Angelo Daros de Luca wrote:
> +  "#pwm-cells":
> +    const: 2
> +    description: |
> +      Number of cells in a PWM specifier.
> +      - The first cell is the PWM channel (0 to 3).
> +      - The second cell is the PWM period in nanoseconds.

Please use #pwm-cells = <3> and $ref: pwm.yaml#

(I'm not 100% the latter works for such a device that is a PWM and a
hwmon, but I think it does.)

Best regards
Uwe

--d734jrlis5p4zo7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpd8mwACgkQj4D7WH0S
/k5HOQgAuth6qs0eRQQVmzrA7KcnhGeXamCLUKP0U7bzLuxFxDPPycvrsB3fBi+L
HURWDexyAUluUJAV5Y7PKtOrdaRn7J5fFtzixzY6Kn3HRI6UGYRb9m/b0JUt1LuC
AW7+TSY5FaAhlLc+dab0++JSIDJfMt/3DvE8l+iQyPkfmfvV66idfQeHwgQz+DdI
YFG8twG5otVYHsb5BsnzcmRvpfOllKpqWqPPDSkNFo6DPoPR3NsNRUs5Fbww/++B
QAKxmpbD//ku6Wcy8AcGiHtC4aIOd5FlZvxJ+Ch9eJ0vXeETiTremots5tKKOrdH
GZ1qrDG0WYgH0OR3H8Ck1ZoYYtAJAQ==
=Ris2
-----END PGP SIGNATURE-----

--d734jrlis5p4zo7z--
