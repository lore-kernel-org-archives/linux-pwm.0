Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E9630567B;
	Tue, 11 Aug 2026 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456483; cv=none; b=JpBnAuEk4AlWCr3eqsXfysI7RHdJw8vzMpZs4VBSeBECbVxEThqsar6eC/4d7lQWwe/cQR1O0HTe0HSIrJo8FYz0chk3wlNoDHBdCUKRnDBCl7ugtqUv7jHn4cjcOiyiyhbh1xDN5pHFLQ9IXCPL2K8mCX8D9oiKXRXb/hjcexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456483; c=relaxed/simple;
	bh=0Iq+a3XQnmuU8OKhx0xHgNoDs12Odag4xbp14zLZDrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq7XY1YZXyH2BFXM76xNcSQz7LaCx/CX7eVEgcMEVbtzPMBHrKkOiH8NyNxhj0TCby12UqTuXTrYq/YtQCtpGWZtOTirPy8nWyeXSn8IijEHt4eunnMlHEubN3VX7s1PJdXHkv+iNWqmMko75iGwPR6mBIWHeH0N1EJrJYt18xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGLfuozP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGLfuozP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95EB1F00A3A;
	Tue, 11 Aug 2026 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786456481;
	bh=0JZA17aHcI0IRIEiveRVYy3aeVmVhVMofUrMfE0EO3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JGLfuozPTND9eWwSdd1YMCkf5wDMHWMqzqX3A10OvSKNYSnavA+xPAMEvITpisaUP
	 NbbEhGfVNf0YAxGZFIzGA7jfaVz5uv7Zz1MSFD/LnlbdPwO24oJCrrFD6u6NJDPeV4
	 q3/7Wvme4QGZ07JUy1dCUZbpZ22KM6gAMxeDxBGWetXSGiPMrxWTr7nrnVxTAtvk3g
	 XHfzbdWwpxK5aOT3FiqVVw9yqq1M1BHV3HAXNB0Apj29Bzc6L9C85iksD3vosiun3K
	 PXrosZyFreHyAxjJTvMK6G4ztVpdrDtzoP+zZzmPo2cEyz70YcZC5Kc4P8lZPYemJG
	 VfUo1/x81zMyA==
Date: Tue, 11 Aug 2026 08:54:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Radu Rendec <radu@rendec.net>, Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, Neal Gompa <neal@gompa.dev>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Janne Grunau <j@jannau.net>, Sasha Finkelstein <k@chaosmail.tech>,
	Hector Martin <marcan@marcan.st>, Thomas Gleixner <tglx@kernel.org>,
	Sven Peter <sven@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v2 8/9] dt-bindings: arm: apple: Add M4 based devices
Message-ID: <178645648045.2076922.10746333465104640376.robh@kernel.org>
References: <20260801-apple-m4-initial-devicetrees-v2-0-5cb07cc275da@cyberchaos.dev>
 <20260801-apple-m4-initial-devicetrees-v2-8-5cb07cc275da@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-apple-m4-initial-devicetrees-v2-8-5cb07cc275da@cyberchaos.dev>


On Sat, 01 Aug 2026 23:40:38 +0200, Yureka Lilian wrote:
> The Apple devices with the t8132 SoC (M4) are very similar to their M3
> predecessors.
> 
> In addition to the MacBook Pro and the various MacBook Air and iMac
> variants, a Mac mini is offered again with the M4.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/arm/apple.yaml | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

