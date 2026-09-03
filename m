Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6604A2A46;
	Thu,  3 Sep 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455081; cv=none; b=Xyzj74bfNGBVMizF49AUcJZJsCbW/cbTwVFnmGi9Gw3PbwJklpja77/Ta+vb+Fvm6HdU2Mqiw6pC/vO619HCIJzA6bBJHsXP28XD/HhUhyQS4iy0eeR1sG8xj6aChBc+nMU6Ohjp8/egFFqi/7KpINFgkItpXqGZCFKTTY3PANY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455081; c=relaxed/simple;
	bh=9ANDRCFdRJf6Eq6viKKbkdbx6xdZ3ttXCN30JBPuFfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sS4uRQhyf+FdAialDW65DtXDdZmKy6SP6IfH+nFR14Vyo4Z5Ips2LUmlnQS4HZ5JpxQPdypcyaSNTRFwiC+RwANaEzeO8hK762LxzIX4dju1IqR36B6BSXWC5xD3KR3XYbelbB8uJVKB8HXof0jRservGFs8sGj6sFf/dQG15rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZpAjm5/B; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZpAjm5/B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+Rm8lf6ex4uHU/asau0I+azeyQMLntFPZVeOCk1JuZ4=; b=ZpAjm5/B/oSSsiOw94H71UlUTc
	5j/puReJXlfTNPndTYTCdebCO7xyL7AQgTjUAeoufpb5pJh2xDZ9RFdYvyoL3EkHqEb2vlwqt0kyd
	cFUuwxWrAVUgz7B3eHUNKurHQSZvUjlioDoM0PNkf0Cx9QcdCRpmdKuzAVXH1jjT4DV1XJLJGpcP9
	NhUDakcMiSE7rOcpbSbSoxA6fOft9D5kS6lLzjius3vejV6HOKfrJszEAI5IzCUqpboQnhJk9USOY
	vyTqT11ABcJoNRtWjtWxOSF4v1SGCou4sJEumu0tudItNm+8cnMgYWnpObnrdtD9MHaN4d1cMN+2H
	sthg0K6A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Arf-00000000EYR-2bV3;
	Thu, 03 Sep 2026 17:04:39 +0000
Message-ID: <e895f645-b18c-491e-b101-3d9fc814b835@infradead.org>
Date: Thu, 3 Sep 2026 10:04:38 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: pwm: Remove bracket
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260903160535.734369-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260903160535.734369-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/3/26 9:05 AM, Manuel Ebner wrote:
> Remove needless '(' from sentence.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
>  Documentation/driver-api/pwm.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
> index 0d27a40f5..d62e3a695 100644
> --- a/Documentation/driver-api/pwm.rst
> +++ b/Documentation/driver-api/pwm.rst
> @@ -177,7 +177,7 @@ and pwm_put() may not be called from an atomic context.
>  Most functions in the PWM consumer API might sleep and so must not be called
>  from atomic context. The notable exception is pwm_apply_atomic() which has the
>  same semantics as pwm_apply_might_sleep() but can be called from atomic context.
> -(The price for that is that it doesn't work for all PWM devices, use
> +The price for that is that it doesn't work for all PWM devices, use
>  pwm_might_sleep() to check if a given PWM supports atomic operation.

OK. Could you also fix the comma splice on that same line?
Thanks.

>  
>  Locking in the PWM core ensures that callbacks related to a single chip are

-- 
~Randy

