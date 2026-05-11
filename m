Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44772F8E81;
	Mon, 11 May 2026 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516382; cv=none; b=DhxpUKzL9h1Nr288LKDDjq37fwcBX1mhmfoTmQMD8AysH+qaTp6cjoXgKobTGdKFKOmxxQD2gZRBe28QExAMWCydxRQNtfmPibf+uJg3lzx3C/ey9oNGYhDWWfK4+gM3ZP5IrLEg8Yfai6y8ggpMdcLR6Ouvepta5rBkfY6FNgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516382; c=relaxed/simple;
	bh=NskC6dmigOoRB1jTRDCnQm+BI1ydTrbvAWPVyxSNjRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GscDBknFsOeLwaoe8TN4eoJbXWdLA0fLp1XSsmExKIoWX+Db9Y3SEa52EhVnWA2vHLFstfZdj6a9avYrnsGMfLtz7xHOOD0BEJiDBT9OAQF/Ewu7zfUUwK7QLLjaQaA5q4bRZ5caCCzNtkfzI5ZWNhXm7lhWdkxQ/u6c7SlkvAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmZOypqq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmZOypqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D67C2BCB0;
	Mon, 11 May 2026 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778516382;
	bh=NskC6dmigOoRB1jTRDCnQm+BI1ydTrbvAWPVyxSNjRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmZOypqqo6QnvKsLUdTwqp6pILghve+sC7s8KM6pR81WAgISwe1xyUGKA8njgOMA9
	 9IE3QLVW2K0lw0PDXZEmeVZfv4iZsWXQ3gGSYRJeX7zqceAY+00Zg8G8DVQlJPyCCP
	 l5p1lpqKSYg2vFkUlqP+wS+m5NmjkAVTqJ1IEoBQUCLvwVQGeWIvhZfiXp8KkHJDHQ
	 RYemROhI5U68K6udVikO7mfgoHZ7kJx2m9RDtviJZp+I1MqVdxsIXUMsM0hyrzjIsM
	 6Ljfe42+IBIkEG6BaZUrZGQJiSpf3Iwqhim7jPyojQaD0g2SXtfNlgq8lZOcYzvVpr
	 3oAtCdKXPtUqQ==
Date: Mon, 11 May 2026 17:19:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Manish Baing <manishbaing2789@gmail.com>
Cc: lee@kernel.org, ukleinek@kernel.org, linusw@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mfd: st,stmpe: fix PWM schema and drop
 legacy binding
Message-ID: <20260511-frisbee-boss-00653c53fd47@spud>
References: <20260509193928.19030-1-manishbaing2789@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KXR1VqJkuf+OgG2z"
Content-Disposition: inline
In-Reply-To: <20260509193928.19030-1-manishbaing2789@gmail.com>


--KXR1VqJkuf+OgG2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--KXR1VqJkuf+OgG2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagIBmQAKCRB4tDGHoIJi
0qCMAQDhDpruGAoFgO2RUtQlivn9XcuSUa9Y8R0GXhaqpERu3gEAvM7LyeQiv/2u
fF9MGycLBRVQ89lLxkL9Ow/EIPU1Pgs=
=vIpv
-----END PGP SIGNATURE-----

--KXR1VqJkuf+OgG2z--
