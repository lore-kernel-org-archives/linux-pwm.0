Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793170966;
	b=pWxGWTilLh4vT2S4AQ6GzrtaeoZOCmlUUquz9WyiJd64CJEdp/dg0EDsNmBtawNrqWxW
	 7Du8BXF3vLV1plau63AHzl72jQ7ut7M9s4Fvqs6Oou5tOzbfCGwq+z+bHuhukaHj/bp/j
	 1cIDUzcYw3jYmpOm+RhVokyoUbj8JfVOI+Aqd9KDnbXX24v9JAA9MjZntS64JovFPpdwk
	 EOz4Ozs85SzuLBrmpcGGMULEYwPhh2XftVs+WlVQCHpJqUg/7aBYwEJTVBPMNIpzMNkDA
	 zdAGnPrxGiDgqptev3G8/OIUFawz7vCplgFbn/0BCA7SMwnu56LdIxq6d1IhzjZDRng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793170966;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=q08GKnMLIclDg6PTr8i2voxZm8I33mhrixHE5JuaMUs=;
	b=gAFXf74OWVO3pbsVyGMRkXMvIRWRhCsUis+Gs9EtAodWrKzCW5Z4HMzjWDMPqL/N6j9C
	 qxeIQTp9zxra2aouUi2W018u3vB23yQPDA+hUSddVJe/ccXbNWEQj1c3/+AxIWd6PiXC9
	 DehalXtkuXs3Ah8CoYxlaKbwr7df/XXHo4fP5ooTYhOGqcNi0M6ATYW7Axwlf6yrqPfCO
	 Umuk1+j9FtNv1+Gz/jwr6tXXCloM4J71VY3rOH54CXQqLqqJ855SYT73xlXhJ2bcLqqIM
	 tqQFdpslasGD/Ci8HWPSvCsWBs2yG9U6QEHgzNX9NYY1WnMfqka6DtBMAB39Aada8Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzZZqJ47;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D36AA606A31F;
	Wed, 28 Oct 2026 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzZZqJ47
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E64751F01825;
	Wed, 28 Oct 2026 07:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793170965;
	bh=q08GKnMLIclDg6PTr8i2voxZm8I33mhrixHE5JuaMUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EzZZqJ47lMCCR7dVk2hu9KwHo/iAZMjZKBzMs+gjAQnA5TfLoAuE/lrZCIOrYBw2T
	 3NJ37YKg2C+FPc+wr4HddAc2Lcwd0PrM7GrlUrbLfa7uiEGHEYphF62rWWWE3Og/BM
	 HivWTNw80Wc5XdUqU6TW9QuFPSLpnsKPaOGmd8esPDUZuLF0SmumPlvE1s2anqINIS
	 ONgZOScwSvGLCwtxsKgrXFKCNBzzddx1VZLNH1PRoP4ELfkSqvk4UHzCK2PzbFwsgV
	 Nax0KXyAkaA9c1MumOTuxrQZkxVYCOzpNvPkB8F//DjxCWnBgE/SjUIDQdlFSSUqCB
	 aMpRoEtnAt17g==
Date: Wed, 28 Oct 2026 08:02:42 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Gregor Herburger <gregor.herburger@linutronix.de>, 
	Stanimir Varbanov <svarbanov@suse.de>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Gary Guo <gary@garyguo.net>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH RFC 3/4] hwmon: Add driver for Raspberry Pi RP1 fan
 tachometer
Message-ID: <auGdsv0OVG4iLjZV@monoceros>
References: <cover.1792748690.git.andrea.porta@suse.com>
 <0d2249a66732bfce38a2260bee08cd1ba4097e51.1792748690.git.andrea.porta@suse.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7352vh2aneherser"
Content-Disposition: inline
In-Reply-To: <0d2249a66732bfce38a2260bee08cd1ba4097e51.1792748690.git.andrea.porta@suse.com>


--7352vh2aneherser
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH RFC 3/4] hwmon: Add driver for Raspberry Pi RP1 fan
 tachometer
MIME-Version: 1.0

On Fri, Oct 23, 2026 at 12:15:56PM +0200, Andrea della Porta wrote:
> +#include <linux/platform_device.h>
> +#include <linux/mod_devicetable.h>

Irrespective of how this patch set evolves: Please don't add new
includes for <linux/mod_devicetable.h>. <linux/platform_device.h>
already provides of_device_id without introducing a batch of unneeded
dependencies.

Best regards
Uwe

--7352vh2aneherser
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrhng8ACgkQj4D7WH0S
/k4mXQf/f5hiHhqUiclt+2CPju6hq8FCsfStkH+EZvSc7NslDu75MRe7OC+1yY7u
nWSyOG6WZJOrBiFEFih2KF5vWvNqRT1lW3XPYx336dt5u3QSAtO/PXVnzZHIxW4U
L8YmwRx/roF86xyaKZ5W1zffnXUSBd/kl0vx9EPzXtxk7QUYcxp7aRf17fkQFr5t
RfO+cCPHdi5EYs2bx1/YpQMw3dxHTNv7Bk9+muv9DArcBaZxXI/dluDw1eKhcshP
z8k28tn35as60d4zbj2J06gpwzuLCyHgyfOoR8ztRK5z46PqHhSNVzecRZFLDeZZ
fMrS+8lBuPXYYKbmDD7Yt/AbS9cvCA==
=+FkA
-----END PGP SIGNATURE-----

--7352vh2aneherser--
