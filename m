Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274730567B;
	Tue, 11 Aug 2026 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456447; cv=none; b=JanjbiEudpxpVYgvj0nnNiQm5mVMcCzwy+8aVpp90cEOmjSxKaeu7hFVCrB8Gn754ZPg9+kmuSXemsDrrSa2XV6evqO0TfHYyEm2kIvMEe2+wGERNA4U3N1ANQgnhY1cgHzZUDcnwaF40xGhLd1MVOyi7omc3ugmVjdm+4dTPcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456447; c=relaxed/simple;
	bh=Va8M7x1oQwy8xaRKxomin1ZJrotaVMxvW7vvwU1gj3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQSuaPzlclee0LuXQtjdEyaj/gcstTusRwM7uYIBa1RCVmGDkUbbsunNWNMh7oIt/ZAGq5hrbqTUd6N2g7MbFz4mtQqiKJp6n3YqsRcncRTQ2s6PBAluQTcFwQu66ioByW03Ipwb+lcjcKLVJCr2diCZkGQB38TAoCOHiADMpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+/02pTl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+/02pTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AE11F000E9;
	Tue, 11 Aug 2026 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786456445;
	bh=4iDdgE/owU51lZlIN0HYazq6pMIvFsHvbr4vWfd/kbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K+/02pTldSr8TyJQf+JRpYO4qxJy70slL1XMJAcUjV6qwEo48GNBLelNXNlQn7Z5s
	 qokChyQ4EbeOB51/Yn0k6ibNNcglRj0FKNBDoH3nCcBQb8LE+X/17iYyWgAZvcotNu
	 izyU1TUwNuYOFj/Hp01D7KYqWZFzkBTW/oNWqY661GdEHoH0Dktb9jiT2fGpGgLhhR
	 W65ZnPF2IWFJ7/V4T7dBau4M4V0mnwgq4kebr2EHSo4nF+hXnS9ASTmm83ccMsyH6h
	 9CzEO3Ilo3cNttuhOzVEsngvW0EU6Fo0FQ7mZ2H2ZKKhgwj4gJebe2k1DZ8DSjRXMv
	 h/xwLWnw15Fzg==
Date: Tue, 11 Aug 2026 08:54:04 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-gpio@vger.kernel.org,
	Mark Kettenis <kettenis@openbsd.org>, Sven Peter <sven@kernel.org>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Linus Walleij <linusw@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, Janne Grunau <j@jannau.net>,
	linux-i2c@vger.kernel.org, Hector Martin <marcan@marcan.st>,
	linux-arm-kernel@lists.infradead.org, Radu Rendec <radu@rendec.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, asahi@lists.linux.dev,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 7/9] dt-bindings: pwm: apple,s5l-fpwm: Add t8132
 compatible
Message-ID: <178645644426.2075921.17129631857001345476.robh@kernel.org>
References: <20260801-apple-m4-initial-devicetrees-v2-0-5cb07cc275da@cyberchaos.dev>
 <20260801-apple-m4-initial-devicetrees-v2-7-5cb07cc275da@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260801-apple-m4-initial-devicetrees-v2-7-5cb07cc275da@cyberchaos.dev>


On Sat, 01 Aug 2026 23:40:37 +0200, Yureka Lilian wrote:
> The PWM controller on the Apple silicon t8132 (M4) SoC is compatible
> with t8103. Add "apple,t8132-fpwm" as SoC specific compatible under
> "apple,s5l-fpwm".
> 
> Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

