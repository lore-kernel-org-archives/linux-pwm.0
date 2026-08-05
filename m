Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1E3B47D0
	for <linux-pwm@vger.kernel.org>; Wed,  5 Aug 2026 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942071; cv=none; b=VSkw/qDbPxUSZEfOpWkc6X34Z6WQXYq/j2Ujvbmln0rtWGT517Dm+vyBF0WSyiJ5NeGYPAaGt5JOweYrI7RTUE1Fb13ZmQ9KjbUYVuPCv/ttYeruwDVXT7znsdTtuVKodSETcQuRbnsniKTJFjwwj4iAOImV/YwEk7zEmGxtl6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942071; c=relaxed/simple;
	bh=rETe+kyKI7gO6eDhLmVRVB5BUJ5GhBZxLA9xY7N02eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBsXc1ctdp5cNcaVxSyAg40x9IGDQd8nBF2Yp6un7W512JMhZBJN+f+Dn7HqGlt3o6d9BT12DCs+CfkXgwR2+2VpJw+fnRb55ydkzt9mSOUfv7kE2rfZaDBxUGD86KsCW7Gna7XoqpO8t8xlOsj5AMG0nY/4niIPfkljdaU8/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLbg52au; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLbg52au"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca957432c7fso1027393a12.1
        for <linux-pwm@vger.kernel.org>; Wed, 05 Aug 2026 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785942069; x=1786546869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z5i0kcxttlog4h9p4Gll70N/vEostWekyPEjeEzGUkY=;
        b=nLbg52auKNxJqk5wIlBNoVRIe9V53cgyV96sf6NtcX3wGoPyP2VGAMlIHSH5rFtWts
         DipJxHnvgsqdvIsHVPU0CvaI7uc2y3XTV4zQkioNkTyhDacPRu7yIdmp1s89uhQKzGrE
         l+YoXtnf1n+K7IUUqIhvq3XgkOHb5ox71UVWaAjmshEPirhd8Nx3RUtoCuKcR7caji9A
         rrk37wsrE1NZo/Xs4pHRwinIU1RQya6H3iR/szN4ghEptAHvRvis9lJhPruAtUSukjSK
         kGqTMDKcSdi/I7DSCEYH3bL2fJcEZi9hO9Adb4HdqGDpnIAoyig35h6RAuXVAiAG8MFR
         r7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785942069; x=1786546869;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z5i0kcxttlog4h9p4Gll70N/vEostWekyPEjeEzGUkY=;
        b=TjRH7yo+x4Wnab6f/lKZBZyvhWilGPBwQNNjqsbwhzHL0C32ZhISub/eiue6MPI0u/
         zKfFndeq6vyPxZ4dDN+l4AQWpuD8Ddm5oOrHb/xe9MJ+Zy1u1TAb0y04TbxLhWsp8VPi
         wkxMrCmC1HcyT7OmGXzZXx76THRlLHGlJXIxJnYypWe04BoFBk0BJvZ0yyUlvmNaXuA9
         SvXF4nViZ/+Ko0f621R/ADIYNaeg/P2cAjBwlQ6ruxybyIG9zv76z/ZTrYtg+3FzLVZi
         ebbvcpwk+O1uzGWVi+ot0x9c6CGw15NYx5pa+xf1CWCUSlOaJZ2hwXGdvKSGCLH6LeJS
         yB0A==
X-Forwarded-Encrypted: i=1; AHgh+RrY7fwdFKu0XQ5Nif4dnncY70F6Bn/cup17eZK2cC7+f+33COeG0wLzPeLgbVaq43fXb2BU+1yVXj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkLKCXirxaS694MJ+pQh35VqDoV4Cx0liXEoGT5XkpridBJsiu
	mikyrg4sz7IAg7bj4svOCGIfaKJ7VVRiX/uwCGDj3YGhYbtaG2eBaiQO
X-Gm-Gg: AR+sD10SdaAeEo7LceGFPRzkYRa7EnIjjiltcCTB40pHKrIMgrLAgzslSX0maLlj95O
	roZal7ZVeb+5KGI/9aa5RBP034AQxU11Wbn8nbScznpNTpKjNz9wfS9CgBzzgoreBEG34Ww9cDj
	R5G4Hi2UG/Ncl4cmV+KYRXUEyR1RSqYeMSYsMvabyKK47kg0iDTnHNqRojNkjSR0ij8ew5ZjF/o
	i+HHflYu/UCOkHV1uOci/AsrabSyUpV3Lpjz1wrNQawU6IVRrsTrJDhhh4Z3zrZGkqUPiT1uxaH
	yAINrRoJCjkKn0ailf53qNLlvg/Zedi04VRS86FX4sUwddzEdwc7AaW9En3BwCLqY8m4q/qFhFT
	Oe62vJZ5EEbZxQREafVR/VHojVxIPHq+WQDJMTk1IBtOnv0VmjKsA+itBpOvsYRSDJP/mstIQpU
	qLQV++kJw/EVbhowC6+qUVLsRbv3vFlutGsQXf8rDzpNMnrWBdvK5SVpE67dzM/s3iLHou1m1WD
	4lRizJZ3yPo
X-Received: by 2002:a05:6a21:3a82:b0:3c3:791e:5e18 with SMTP id adf61e73a8af0-3cb85df09cbmr8984012637.7.1785942068906;
        Wed, 05 Aug 2026 08:01:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca63ce12sm18114476c88.5.2026.08.05.08.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 08:01:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 5 Aug 2026 08:01:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [hwmon-next PATCH v6 4/4] hwmon: (adt7470) Add thermal zone
 sensor support
Message-ID: <bd7b1dc9-239d-4d97-9593-1d1888fffacd@roeck-us.net>
References: <20260805-adt7470_thermalzone-v6-0-5605a5f95467@gmail.com>
 <20260805-adt7470_thermalzone-v6-4-5605a5f95467@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-adt7470_thermalzone-v6-4-5605a5f95467@gmail.com>

On Wed, Aug 05, 2026 at 10:15:20AM -0300, Luiz Angelo Daros de Luca wrote:
> Register the ADT7470 temperature channels as thermal zone sensors.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Applied.

Thanks,
Guenter
