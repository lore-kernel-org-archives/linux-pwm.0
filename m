Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489903BE14D;
	Sun, 26 Jul 2026 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785078295; cv=none; b=Q8PdStiK4/7F65hTvq0KWzEpfcrncsWW8juEtM/+HMl+hbRryDIVh+3celsb//6g4TmMf3IFg1pGtYhCyNoycuK8a57WELXVBszMg9OeO1tAfxPjtUxDi24AenCP1e0jHWl7vOqwBru/Kr7xsJoqWhqy75ylwUwLL6NB+uNsY5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785078295; c=relaxed/simple;
	bh=csB51aVjTZcEcHOBWCS9WX9GJfFOxr/N7RTtTcadqPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/xWDY82hbOenu+TCEs/Tf4037HHZSfcj4br92MY0T/hW0CRp/ydHcAWRx7XWGoEjGpuuNHf0lNgQVH7lGdXPClQ022SyMCAYQqjVEGTW5FUBliE4sEU5ppXVs6+62mAikuRPMbK8LkJ8fLLjqIaoIOoWPz/URxLnEK44rHbWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvFpVa4d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvFpVa4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF901F000E9;
	Sun, 26 Jul 2026 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785078292;
	bh=czLPdPzPEzGnxXOs9XFKlCHUMcOVjehz+yDqbFnpv+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TvFpVa4dtTLHvYfummoGuesnzNWH8hYrYfNL8htixBDEZs3aJUd5JJ4bq7qSs5L6Y
	 fkrZbHRSwz34OOxPBeaP7LJwbQZgBAeIVTSCnUWXZusU/jfasRdQoYTerwHwIcobpA
	 6a6CjN+zbZUAIbaGpBtiRcO3wA4hC0L281E5+/Qu5jzBr1RGEq+ugZgDRqxNgwU/xx
	 SvQom09I3hti+NH3cs7Qw5TDRoTCHzN0+cm9t7SkXtaK2lqyy92ObnGGMLItqKfM4t
	 goSwp79B/u/zx3kIRzls+H6Ed2bdbdNccJGxxaO+sDE+jaI66gimL8JRB+suow6z6n
	 /qHzLjZHt5h/A==
Date: Sun, 26 Jul 2026 17:04:47 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 6/9] dt-bindings: i2c: apple,i2c: Add t6030 and t6031
 compatibles
Message-ID: <amYh9XtzAbTtdWZq@zenone.zhora.eu>
References: <20260724-apple-t603x-initial-devices-v3-0-bbeba0420603@jannau.net>
 <20260724-apple-t603x-initial-devices-v3-6-bbeba0420603@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-apple-t603x-initial-devices-v3-6-bbeba0420603@jannau.net>

Hi Janne,

On Fri, Jul 24, 2026 at 08:16:46PM +0200, Janne Grunau wrote:
> The i2c block on Apple silicon M3 Pro, Max and Ultra SoCs are compatible
> with the t8103 (M1) one. Add "apple,t6030-i2c" for M3 Pro and
> "apple,t6031-i2c" for M3 Max and Ultra as per-SoC compatibles.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
