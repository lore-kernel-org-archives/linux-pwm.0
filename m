Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F7D35C6B9;
	Fri,  4 Sep 2026 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788557692; cv=none; b=sK7wQ/9TeX3PI2yR6OnzZ43VIYVtngqskFF1AyjkoDnPyFMU4gCzPRdIR/on172TkPEIJYdBgBOe/BTC2lbrkbekk8y/eaaf3Z1JhoDVl8uL0SFRn6kaqBiBqLc8MBC5pTnNSfanfEhWpVdYYDYq77r0eGxSpWLsjcNg+lUxdg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788557692; c=relaxed/simple;
	bh=eYsQ9wYjUVqCXRIvz/h7ndFPW0C8zKYA3HnxTGx5gMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxaD4sYkgFokgmkGfUnIi16NxIhi+rdo+LIyhHfPOjxhMV4DfUU55oWo7ypCD2Fgn2FPooHNKgp/yAJSMoStOVlT7TCxAAqV1LlVIItdMztXnHVuOZ0QNC0helHx31QviQbnHheGE/XZBA2PUnCkggXmQsap1Jf9555c46lHj6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QMwIFr2A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QMwIFr2A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Lel1DOXtD3Ub6sio9IDHpYS0Ag7RgDQ3Xza2Kew7SsU=; b=QMwIFr2AnguraDB4rwMB+8fJ4v
	X0e+ZKeVxTTikXlhy5TDO8Lq2xm0KMQA6jFKQGaVqCe94Y4WBt1Atyk7PyIU1xCIc8EflfVDi2tsy
	1pNfP+x5orGLCbx6ElpgUOfTqpPfDxof1U3VBpgX5J0tIIjB1RVu5X1rru5gYYi6QJEDr+0rwSDY9
	OxL5E+eSQYYiT4YYYV1oyKPxWzpoBZXEap790BkhzNlx8Ll6IMO1PQYktgcaiPWHpBqv4l+V7PGAh
	IBmZacuOQP1Neqi1zSQVmyOadX2OhMaq6k8+MgY75kZa9MiOoiCD7wxSyZHyKn0m4bcRCOUaSjK4y
	FPJsO+Pg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2bYf-00000003Koj-3SZy;
	Fri, 04 Sep 2026 21:34:50 +0000
Message-ID: <bd65118f-84ed-4f23-92cb-782a3e59ab0d@infradead.org>
Date: Fri, 4 Sep 2026 14:34:49 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: pwm: Fix bracket and punctuation
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260904122005.760299-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260904122005.760299-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/4/26 5:20 AM, Manuel Ebner wrote:
> Remove needless '(' and fix comma splice.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> CC: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
> [v2]
>  fix comma splice as Randy suggested.
> 
> [v1]
>  https://lore.kernel.org/all/20260903160535.734369-2-manuelebnerli@mailbox.org/
> ---
>  Documentation/driver-api/pwm.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
> index 0d27a40f5..b6b67f7d4 100644
> --- a/Documentation/driver-api/pwm.rst
> +++ b/Documentation/driver-api/pwm.rst
> @@ -177,7 +177,7 @@ and pwm_put() may not be called from an atomic context.
>  Most functions in the PWM consumer API might sleep and so must not be called
>  from atomic context. The notable exception is pwm_apply_atomic() which has the
>  same semantics as pwm_apply_might_sleep() but can be called from atomic context.
> -(The price for that is that it doesn't work for all PWM devices, use
> +The price for that is that it doesn't work for all PWM devices. Use
>  pwm_might_sleep() to check if a given PWM supports atomic operation.
>  
>  Locking in the PWM core ensures that callbacks related to a single chip are

-- 
~Randy
