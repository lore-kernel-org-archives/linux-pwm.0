Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2054B477291;
	Fri,  2 Oct 2026 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935748; cv=none; b=AGxOmTtuBSV4RleuxAhkeD25SYt0ZlZrXtyqiANfyTGdJzdONCDicgOPczTBWn41vTcbnqWmxqPC1jYYjEuccZtgz7CWrE3yiiERpwVDPqxr4NC+YEYK9ihkZLI9lBceHpA0tVstwmnd+eglQbjzH4TcLaDPNRkIVKrdZ6+skdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935748; c=relaxed/simple;
	bh=nOXcDrUoaq7D3/iW07c5+YzJfmnlVVdbiOfZn8zRDFg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YZp36PJ/mIbk0NKtCynCTBLtsrceGKlsP9I2aFODz8foCp4LeNmO+qco3O+6f3GPsWSJqNJUHd5zPPkAEOwkeBQjHA0swn4NEWV05ioz3xdRai88N9Wvvdx0+5Ti9liiSXYgANyQl1fryoxJr1n0Kzh9ZUyO7A9sO4c4dIJWpsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtJhHLb8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtJhHLb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DE21F000FF;
	Fri,  2 Oct 2026 10:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790935747;
	bh=42gWHDf6qE5t6dpfm57PHhsfmnmVxaBF+alyU8miG1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gtJhHLb86ean7gBFJFYA9TuiGzTM4C3FG+cKNU0ehBeWyMY9mQj7qECiCPDTH/9Jf
	 Q5RdWgCoS0CXh1zl/9lkqSU/xsKooc11ZNO4PTMJp9C3KqbQdmaURA+kRlLaOMiREL
	 2ZPDtk9cH86EAo81E6SWf1khi+SUhkQ6xbouCSAV7C2fq53O7hoYZcqhIWZHfQod1i
	 07dWxCmaiTEiOwtLqv1Z4kblKmG0BcKxM0kGHIyLYmQ8+1MeXie58cYW4zTOkedJC/
	 8f9rvsspwVQwfZYXZeke+lOxqSoDV/bSb4M0aeO25hR69BjrmuM18C694NZhEmBcGU
	 PkwzBzJog49xw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Chaosheng Qu <quchaosheng000406@163.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 mfd@lists.linux.dev, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260930023923.49917-1-quchaosheng000406@163.com>
References: <20260930023923.49917-1-quchaosheng000406@163.com>
Subject: Re: (subset) [PATCH v3] dt-bindings: mfd: convert lp3943 to DT
 schema
Message-Id: <179093574476.188646.6343142834887336950.b4-ty@b4>
Date: Fri, 02 Oct 2026 11:09:04 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Wed, 30 Sep 2026 10:39:23 +0800, Chaosheng Qu wrote:
> Convert the LP3943 MFD binding from free-form text to DT schema.
> 
> The LP3943 is an I2C LED driver with two sub-devices, lp3943-gpio and
> lp3943-pwm. The GPIO sub-device is covered by trivial-gpio.yaml, so only
> the PWM sub-device gets a schema of its own.
> 
> The PWM schema documents ti,pwm0 and ti,pwm1, which select the output pins
> of the two internal PWM channels and are read by pwm-lp3943.c with
> of_property_read_u32_array().
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: convert lp3943 to DT schema
      commit: 88e0bfab55e131fb2179dc3eee5893e9f638926b

--
Lee Jones [李琼斯]

