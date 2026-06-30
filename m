Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FDF2F1FDF;
	Tue, 30 Jun 2026 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782801178; cv=none; b=hSo308IslRfezB9CEfAD1lXGFtzYt6lcAPMxSeCsg4kfqa+1eQERgSiGYOWhDShig+JjCjutJDW8QPQsFift25P6bVQGE5cgeKot1GgCejh7pYKW/MDE7VdCB10zPFuL21wPYhSj1nXBWde0d8OzMlmWTJyaSYNJLqgReqLWAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782801178; c=relaxed/simple;
	bh=I9t8nQfOjj9/aUr9XFtsyxbPFcqWKMnzkHixQOT91Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glRIrRlbOjOGSMpftcDddsTSMbrb3cRBscyXTfzE8UXk2ZL7YTnFqxz6bTmwJq0xVzFtUpSd6JmBHRo08hkw54kTbxNDfRIF0Kgc75wiiXFFlDg0YGb4o1ON4a+5+/TjC8Rdl72wPwmJhra+B7xCPQBTon71WKe8SachyllEn+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biKk+QvE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biKk+QvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788FB1F000E9;
	Tue, 30 Jun 2026 06:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782801177;
	bh=Kl+w1FAsj/uySaEZ3UOYaV3smbCW0UBPqhVmiNwbMjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=biKk+QvEthSVytwRLlPpvQ5bnk6zb5nYVb/Spo6lktHn44Tftb5SYvxdiAc6tPfYk
	 a9XJJ7ilTLLGxpluwYWie+kZc01Gn9Jz50hp9GiS4wO9yyQ6HoeZQ4Zu8onddMhf0K
	 /aW2HFzzKe/d2u5ZIXf+/7hn2kP15E0EsAnYxC8Q4TTlJNi3sDwO/8ZrMouGozbjw4
	 URhucxpOIFCTYo5pqF9OG6CwpbCPv5Usz5gEnSL8zUwnbsl9P1lY+qsfi8lboaF9s2
	 N/tj01GMcYVzzkZ+OC65DQEWYv1AWWlWcSMuV7Grn3dOEy7sb11JFADLPA+noFym14
	 IahmX3BRmOHQw==
Date: Tue, 30 Jun 2026 08:32:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: pwm: st,sti-pwm: convert to DT schema
Message-ID: <20260630-antique-iron-chachalaca-a7560e@quoll>
References: <20260629-st-pwm-v5-1-a93f2bfec38c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260629-st-pwm-v5-1-a93f2bfec38c@gmail.com>

On Mon, Jun 29, 2026 at 12:58:37PM +0000, Charan Pedumuru wrote:
> Convert STMicroelectronics STiH41x PWM/Capture controller binding
> to DT schema.
> Changes during conversion:
> - Fix compatible string from "st,pwm" to "st,sti-pwm" to match the
>   actual hardware variant naming convention used across STi bindings.
> - Drop pinctrl-names from the required list as pinctrl properties are
>   inherited and validated by the pinctrl schema.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

