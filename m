Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.21.61.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794779818;
	b=bxqS4cklzEteFAnXZWksWnUOOcLuzsWquxxfK1hUAwRC8yovzen47bKxJHfeCC+bnFzb
	 t6swCkoNvzyhQC4sFqOMVoTOK/ruPlgqkRmzCWi42zjHFx9yH5BUnh8cjSqAw40eYfchw
	 aQ4GZNeLgijhQ0rth7g5V0XZO0feP10FFe6/5vXTc/02AfppoIAFx045QUziHSkv3OGTu
	 qjFiwDuQDHJS8f2E0JWuK9TvoAgOiJzVMlVq36uhWB18WFEjTkY1y4ItwaCK8fI3iO+GV
	 I4QFrcMBr2omtifhPibmxzQYBBrm5tQi/E0Z8rjOeib+w1VpIegxc9yOQBgyDEM4RPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794779818;
	h=DMARC-Filter:Message-ID:DKIM-Signature:Date:MIME-Version:User-Agent:
	 From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=WrHCNL0KXrXk5rA5zdalOrV02Xy8jJVbUwtw3kWjMOM=;
	b=O3c6UHGkc+ih/qI8Lw2us9VhTzgxP8DVOBxEBdomFu8qSVYCZLlPiU1J5VcCoI+5ehtd
	 55+KEqT5YR/hLpw/Wv8pWvjubh/cjeiIYqffj+Y/vMi9vNni/9Anyw8TZPNhGCouk7lnV
	 KbVa5HSjnIRYIV9FexHK3YGHI1aAwZZNh7rfUZVSkIwYIj4+zi/I7NvG1v0peifHUlnTF
	 hBALwRt6hhrq1oW3qu0gaw6l/yWt6rKNGW7zznqypCWyc0xXwio3jPwGlnuwwxJ2ddBQd
	 erx7DsT22oqKtMujwvF9Lam18mrlIEbZMBAzq/InZ2CGuIbUlJGYc4yMVdyJwdB0d9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aliel.fr;
	spf=pass smtp.mailfrom=aliel.fr;
	dkim=pass header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b=GEv9vjch;
	arc=none smtp.remote-ip=65.21.61.41
Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DAC606A33D;
	Sun, 15 Nov 2026 21:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25DAC606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b=GEv9vjch
Message-ID: <e526e0df-d3e8-4c6b-ab50-e9b4cc9bdd3c@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1794779809;
	bh=Wsvy++1Jhz31GNLY6mcfL2ulnfXKznpBChaXnW8X7ME=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=GEv9vjchECQHtag1czQFsuwD0vdspJK6CbtnGjHm4SsKXaQjIMKp5blcTP+3hWOmb
	 morU1X6i1QQuY6BlyafEREoxPdQ2ZcQ57pY+krO6WuGQ2vyP5i+pUlJ6WirubpYM0O
	 AFn7GDQ8CLgYTUlu1lM7iZg+A1K1SvVSS5ZzgXuE=
Date: Sun, 15 Nov 2026 22:55:51 +0100
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH v4 0/3] Add T7 PWM bus clock support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
References: <20261001-add-t7-sys-pwm-clk-v4-0-8ed2b1e0cdfe@aliel.fr>
Content-Language: en-US
In-Reply-To: <20261001-add-t7-sys-pwm-clk-v4-0-8ed2b1e0cdfe@aliel.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/26 18:55, Ronald Claveau via B4 Relay wrote:
> The PWM controllers on the Amlogic S4 SoC have a system clock that
> controls access to the controller, in addition to the two input
> clocks of channels A and B. The A1,C3,T7 which fallback to S4 have
> this third clock too.
> 
> It is currently not described in the device tree, so it is neither
> referenced nor enabled by the driver.
> 

Hi Team,

Do you have any idea on how to move this series forward ?

-- 
Best regards,
Ronald
