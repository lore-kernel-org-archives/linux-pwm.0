Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9384D35AC17;
	Fri,  3 Apr 2026 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201259; cv=none; b=UgtUSsJSLwriT2aAtU9YAlDvqqW2ZtcZfWtvT7UtG07SpWaZJFF8ZWORVUTQo6TIqaMGKQTGEBGOoKCqMq+150A7wb6OsSXkYK6Trxzh6orl9iomXM/sufWtAwlmjhTaqUUa2CaZWbXKRdSZMZ3a5blYkMVVC5m9KmRx2g0NnoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201259; c=relaxed/simple;
	bh=2vo7+fR3vUjOvvIWMIpPkrw6WJ8KcnfyAW5ibwuUpKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBENEjdddBiGtj80ImF3KUrz6TGcqqUZ8DknXftcgcMSbx79UqaPr1elBw4UdxfgRbWqOsaRpoZqrx0mIE/QfaNWelpinGgXogzHxtZvZJdQMDgF70mYBoAUIBjSXxyukgnvdKtS9Hp/c5tAJqoWBEBtBtaFd6HahmBLoax2KYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwIiDh6B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwIiDh6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80C5C4CEF7;
	Fri,  3 Apr 2026 07:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775201259;
	bh=2vo7+fR3vUjOvvIWMIpPkrw6WJ8KcnfyAW5ibwuUpKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwIiDh6BaeI29WV698WF/KodgC80rkQQqQT3suX1ZVXp8cFTr2Fx0QuP5hRqkxfT/
	 0cjasxASspJCmf/XCQZ7sy83izC74x6GwLm//Gl3agf+Cy/l0C8tF+h90Hr5uLtCpD
	 uuQFqIoDguzQD/uMryv60Xa3YEBY82K0lWXoPeKBQW9ZhGfoP69GI9ITRLUL1fkhtr
	 gvJ31Z/GxPCxzaUyiTuun4oDc7eekYaDp8hKN4AoWEoFJEqg5KHDfqfyiC63vXeyqz
	 oyzcFDDg/rb05ywk0YE0sYhC5sDZAWTzgmEW01GfH+HlKWK1lS8cxXUbyJbl468QEK
	 jO87ey05Oyz/w==
Date: Fri, 3 Apr 2026 09:27:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk, 
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: dwc: add reset optional
Message-ID: <20260403-glossy-industrious-pug-4f2b2c@quoll>
References: <20260402091718.1608-1-dongxuyang@eswincomputing.com>
 <20260402091854.1666-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402091854.1666-1-dongxuyang@eswincomputing.com>

On Thu, Apr 02, 2026 at 05:18:54PM +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
> 
> The DesignWare PWM controller provides separate reset signals for each

So one controller has signals. Plural, right? Then why do you define
only one reset signal?

> clock domain, as specified in the hardware documentation. Without
> asserting and deasserting these resets during probe, PWM outputs may
> remain in an undefined state after system reboot.
> 
> To address this, the driver now supports an optional 'resets' property.

This is binding change, not driver.

> A full reset is performed only when no PWM channel is enabled, as
> determined by reading the enable bit in each channel's control register.

Do you describe hardware or driver behavior? This is not a change about
driver. Describe the hardware here - what is expected with that reset.

> This allows safe coexistence with bootloaders that have already
> configured active PWM channels.

Best regards,
Krzysztof

