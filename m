Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212437E5FD;
	Thu,  8 Oct 2026 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488752; cv=none; b=flkSsHlb9Ux3bwS752c64OPXTNMfXkrSZISoFZg7+FfKKRIwJOHdrMkI5RCu2ZBk0pvL2YQepCFus+aHoCJiMZHNVRqwuM/bie7RddS9jKGll0hJafBslCcg5fBLQ64+9MGv1CQDVbEsrThw9TypsNilEnl3bxJA9tOjiNPopmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488752; c=relaxed/simple;
	bh=4UyLTIS/qxKCt1AXo4psa9BmH2o3OMVTVJCtzcrSsJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=no6TBu24ndzY96ynJRbqPc/RQYv/kMJaB0FmWyP7YsyIrbJtvbNIE1vw5BS4grArdGqXQ71skrw0GSRgy2Eu1DjBceST7JK2TCF+cFxuEeCkl8QkpUP/LiRc3sGp/xVgcKtG1Gloy2+fo+fgQ4iWBIQMR1fb2Lf4uBqSkk9Wx+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ7v8JTK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ7v8JTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E311F000FF;
	Thu,  8 Oct 2026 19:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791488751;
	bh=q+Q6stYCq6cZJyDhEdIvVjO7t8cw3BzIFyIxVu6yjX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mJ7v8JTK0w2/G5CsjU6uURxIXMgNZXsxT4rY8s8Zoh+oQf3qwUovZu5EsU0asJeET
	 5tSzG1uAu4u6XgbePbaAuG/DsMY62h//8TI1Kbwc5eMaFUAwpeeXJd/psQuw4W4wTz
	 KJ3SSf3tjxzDox8N6YRCqVvV5on1Kj/DN6TIxstzqwOcRJ0wvc3YfNRDnD/l/QEIc8
	 T8dQa4jvTncfKzIfVSuVNWexZBefKR/5z6TesWjw/J3VY2F/TLUY+lzZ34aI0W88lD
	 UpAua6vZ0J6tkNL4x+sfbdVi3quExEJzfBgy4fPqXnLQz9LqPSHDKMWFM1Edr8NOEs
	 hDVKmwOmeabYA==
Date: Thu, 8 Oct 2026 14:45:50 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	George Moussalem <george.moussalem@outlook.com>
Subject: Re: [PATCH] dt-bindings: pwm: add IPQ5210 binding
Message-ID: <179148874952.892086.1972349791589080283.robh@kernel.org>
References: <20261008-pwm-v1-1-0b8776398632@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-pwm-v1-1-0b8776398632@oss.qualcomm.com>


On Thu, 08 Oct 2026 14:14:00 +0530, Varadarajan Narayanan wrote:
> Add DT binding for the PWM block in Qualcomm IPQ5210 SoC with
> qcom,ipq6018-pwm as the fallback.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

