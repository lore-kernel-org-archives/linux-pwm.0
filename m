Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571413;
	b=cJPAGDYjUH4c07YBMp0DN1q/ojiasoRfOZrLUWWPuh4tZukwHQ/6DOtrDy8wuwYPttdD
	 F0qbvwWikO8ibilOxrdTNIdsGairSv1zEF1lsPgREUoYvoTzPkwrUYz0d3ysNbUbJNrnk
	 pcsRqEF7QIfdZ5+wrYoWUuU0kAHHw1lJ0NuiqqFOdDWgsYoOnaKDa7R65KnK9lG/c+XEA
	 eiiRGffrolsYGH/8ES4liB3IauzXkLt9H4zb1HDtP+ZZ61eTUUiQ7Xjjuxpky2OP+qLBz
	 0JBNkXfOeue0Q7wIPH5IOxLYPnsS3z0WxieThUplJcFuwQYrcn3PAKKJ9VuvroMo2Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571413;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=R/bKUVygQmmrYTuRm9k4uP1auZgpb0gZfWPM2miQjnw=;
	b=IB4MAXBiR8FZLnTWT74oxcqdFffLdHisVk64rJZPzITvlq+ErT1YNoTVWDBG59FLK+Xg
	 ymHdw72JcBr3NxhDvgHuWw68TlyTFXim+zj8lqhj9kXJOB4Ojbg9ocrdKlCbRJysqmAc5
	 TOtw6E08FcV/10k8Gg76Ijzd0KQTMizA01ckh3FM6uf+o99MEhM2aSLbO2ncDntACgcC1
	 iWeOKQfMB1ZnYf0sRUDoowwzvyxnayYHQxnXaOqueFbfev3Til0WO/wd3RbBD9bDVH3dL
	 lJmQBfSR068Sty/39RzImkTHQXTZrkqN6be4GQKMMyuSyKiN1p/tBYcojzIgAUjjZPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e7A8Cvgs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52EB6072170;
	Sun,  1 Nov 2026 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e7A8Cvgs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499EC1F00919;
	Sun,  1 Nov 2026 22:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571413;
	bh=R/bKUVygQmmrYTuRm9k4uP1auZgpb0gZfWPM2miQjnw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e7A8CvgsLR+P85In/cqf5teG1i56/z+xxZn3GQOfofjUdlB2fVQynrtbr2W1/1aqe
	 +4KwOpykFZFbAMOaM2gd0eUFvVGzdZY7aoLUiuVvDUu6K7o5K8USTQ2HqAAFzrsFrr
	 DPtQmC7Yg02AxB2O9kokMig4jAaS+86VYzru+qxDqTWNMOSwJQzaLkdk0YMWA6tKYm
	 ++ViQCAvb7sEJHHdUuce9ru34+IY9z5wFevuJnHNlmu/3GQKuNXnqg1yF8GEE8JRVA
	 MwJYfEpe7fXfDWwyzFoGuRZNcKwUbIW2Xx9lsxy7wL5JanRHWBJckgHxMcV5blV7BQ
	 Y72Cn2H9f5T5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401C038003B8;
	Sun,  1 Nov 2026 22:16:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND v22 0/3] Add OpenCores PTC PWM support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357141185.2624073.8394896290201314670.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:16:51 +0000
References: <20260810030714.48100-1-hal.feng@starfivetech.com>
In-Reply-To: <20260810030714.48100-1-hal.feng@starfivetech.com>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: linux-riscv@lists.infradead.org, ukleinek@kernel.org,
 p.zabel@pengutronix.de, robh@kernel.org, krzk+dt@kernel.org,
 conor@kernel.org, emil.renner.berthing@canonical.com, palmer@dabbelt.com,
 pjw@kernel.org, aou@eecs.berkeley.edu, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Conor Dooley <conor.dooley@microchip.com>:

On Mon, 10 Aug 2026 11:07:11 +0800 you wrote:
> Add OpenCores PTC PWM driver which is used in StarFive
> JH7100/JH7110/JHB100 SoC.
> 
> I will maintain this pwm module in place of William.
> 
> Changes since v21:
> - Allow non-zero duty cycles shorter than one clock tick to round down to
>   zero.
> - Drop the .free() callback to preserve the PWM hardware state after
>   pwm_put().
> - Update the comment.
> 
> [...]

Here is the summary with links:
  - [RESEND,v22,1/3] dt-bindings: pwm: opencores: Update compatibles, examples and maintainers
    (no matching commit)
  - [RESEND,v22,2/3] riscv: dts: starfive: Correct pwm nodes
    https://git.kernel.org/riscv/c/2186ec5f59c2
  - [RESEND,v22,3/3] pwm: Add OpenCores PTC PWM driver
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


