Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE74E0B8D;
	Tue, 29 Sep 2026 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790717852; cv=none; b=a9eLXfH5gMolNtTcHK6zBU+EBLKUecJTKng4/QjzFQqOdEF931DU/wvPZHSNP7cCJDU8HYFyC41yKKneGngijzCnRy7D2/YPWOBfy/maWfLOxkoNunCK93YGqwQT+7Q55339e0nJgR+s6KT2JHm1CoviC2oeACCXIDV9W5EgpBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790717852; c=relaxed/simple;
	bh=aru0fLcUFwNUt4nTkehSL9f5cMw9Ei5VFNXxkLlwOiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKN6gM+dBGk8c+FVXhgGWkTWo1l3+KPHrk3s93n/tvuEbyyUC7//3LlhzShaiOswpoDBk7Zjp3xl3FyWu1SYz/Cb4e7bChagRMCeJ7OmtjThITHtDu1wkTCDlFFuQ8hJGQRDfFYAsI1jzJmrtFuw5XTRLK6XpPrd0mb09dBdMuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZerkEkyc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZerkEkyc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92251F000FF;
	Tue, 29 Sep 2026 21:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790717851;
	bh=B11N4wmqUEXrSapXqi4bJR3HMzWuEQfMnAAFeMKPzww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZerkEkycSvlmUHsTgWUQGweEcC4y0RHzGZa0L/tuN46HLSmtwVgbB4l8+Gw8rQZwb
	 1aPK2Ey+z+0nYuGBNXsfRTEFBWXThtKOMuuCmV8YUyaoPQrayQ1dISHElroIGXZwtU
	 4W+7CcZF+Kiga7iMBkpRfr6j/UpeO9JKk/3vOBA91tgB2qksxNqRlCZXQACMEYi/xT
	 ojALRZ5xRyN3NfEfl+uHsB1KSHEzCRXUANseT+DySFF9biAvaotrzpOqsxLN0TNg8H
	 QDri+cZ3Vn/P9nxre2ce9xRD95ClvU3qd1yiS6eEF6LXsAy6JLWsbIV4x+crt9epDq
	 LMyDUIQTARPgw==
Date: Tue, 29 Sep 2026 16:37:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, mbrugger@suse.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, Julian Braha <julianbraha@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	linux-rpi-kernel@lists.infradead.org, Sean Young <sean@mess.org>,
	Stanimir Varbanov <svarbanov@suse.de>, Gary Guo <gary@garyguo.net>
Subject: Re: [PATCH v12 1/2] dt-bindings: pwm: Add Raspberry Pi RP1 PWM
 controller
Message-ID: <179071784935.2855464.8360313388154937675.robh@kernel.org>
References: <cover.1790686331.git.andrea.porta@suse.com>
 <ee0aa89faa14e0073f1271693bae28678652998b.1790686331.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee0aa89faa14e0073f1271693bae28678652998b.1790686331.git.andrea.porta@suse.com>


On Tue, 29 Sep 2026 15:02:11 +0200, Andrea della Porta wrote:
> From: Naushir Patuck <naush@raspberrypi.com>
> 
> Add the devicetree binding documentation for the PWM
> controller found in the Raspberry Pi RP1 chipset.
> 
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../bindings/pwm/raspberrypi,rp1-pwm.yaml     | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

