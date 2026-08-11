Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C819D36215A;
	Tue, 11 Aug 2026 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456424; cv=none; b=hXnnxF5Fm8+SFTwyig6q1mlbTlpE+pC05300MO4IXQUqynYQPMoEGmbNxDZKWXcesf7rQlOd85SzkT23bCbSFDenwkP/nokg3TyuckOVjhRvBZe/WLCT1ShNhrQ5CehdLYT0skK0eTz+ngwmuarCcZDH0YFTECKM4qBrkbjj0o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456424; c=relaxed/simple;
	bh=XC5Z7K4swmJTpro9CxD2XzRI0JBMChZa8G2ZXsG3tOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4ZmpbrK6h/Dv18I22/u+IwFkgi3ZgbGcKL0fIdgD4GX2W/xeBqMfyCN4t2TeGSdD7aGymAdiPc35SYPGhz/2a6wUKnzMnAEhyo12SHSTJcSGda6FEpn+n5Tc5yvBDtbCs/0ohNNp7XtquwxTW/RXPmS/tR25KRiMl8/aR5C5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2HM8ACr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2HM8ACr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094931F000E9;
	Tue, 11 Aug 2026 13:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786456417;
	bh=cXxRUdXqmfxaZfLrJ4X9zDN6u+LElKEVesAj3Tp9yj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T2HM8ACrzefnEewnDI7WsdoKzf3r3sMzzekKlS5Omm9nrOWlYTMqL4MApiTPRlpeG
	 WhD5Yqv0Z/eO6sf5YyB44A5OiGcfw48Gg+6sramLudG0jjFsK1V6RGBN9w5T7QM6IB
	 bVKsc7/doSeGgQFW9MTNhXKXj9WPWs1/GGB+B+62f1xe5h5WTAHgxh1LbaSrrtAfR8
	 NzBzfn9SnXS7q1BpBTJFS/GXajWD4YUUiIBMjNK25VPNDtjcRDtQM//wc5SYCEcmNJ
	 Khidd8S3VvLjxzclUIHzbzu/t1FAuTg0hmhJiE/gYrWNA11xLs9gWwERXqSs4eKrfj
	 dwW5uGbDbuzGg==
Date: Tue, 11 Aug 2026 08:53:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Radu Rendec <radu@rendec.net>,
	Janne Grunau <j@jannau.net>, linux-gpio@vger.kernel.org,
	Neal Gompa <neal@gompa.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>, linux-i2c@vger.kernel.org,
	Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev
Subject: Re: [PATCH v2 6/9] dt-bindings: i2c: apple,i2c: Add t8132 compatible
Message-ID: <178645641594.2075087.11441421386167172018.robh@kernel.org>
References: <20260801-apple-m4-initial-devicetrees-v2-0-5cb07cc275da@cyberchaos.dev>
 <20260801-apple-m4-initial-devicetrees-v2-6-5cb07cc275da@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-apple-m4-initial-devicetrees-v2-6-5cb07cc275da@cyberchaos.dev>


On Sat, 01 Aug 2026 23:40:36 +0200, Yureka Lilian wrote:
> The i2c block on the Apple silicon t8132 (M4) SoC is compatible with
> t8103. Add "apple,t8132-i2c" as SoC specific compatible under
> "apple,t8103-i2c".
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

