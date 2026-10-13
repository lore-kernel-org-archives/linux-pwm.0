Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E368028B7C8
	for <linux-pwm@vger.kernel.org>; Tue, 13 Oct 2026 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895759; cv=none; b=JWgHVFvMFT+V1NMt4LJ09g0mwO9GD4KkDU7j+qD8PTBlFuoe0lH25gHVblGfXhInEh6gdqdDvNQGZPAJuR7BogXi6Myz/z40yUKALjkFN2+6Q176r+1ExSJyxEvdROJ+RWWj6FONAbTMszc+BdjJdnGvh7I73DpsjzluCIGZVBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895759; c=relaxed/simple;
	bh=hy3ocuhI/6vDP5S05nfHI6W3yZv4jEsBq9cAYewde9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYN7YfVO+zMRC+GeQz7amnlKVC7nmz8LkCXf4PKyyzXoD3s3CBYk2qOq93/7JWsj/Xldml7bg+tY0yBqC4YYR4V66AvuT/6DvYXfv4qC0SmpDluupYUTxkpp11DGZJ9w/NSANhtyu8DQVTnrahYqhFjo9uJfeIwcrATeRpioI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVCTX84K; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVCTX84K"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso2808878f8f.1
        for <linux-pwm@vger.kernel.org>; Tue, 13 Oct 2026 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791895756; x=1792500556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WOn8xr8BpKgnJ6Gee1th0C/2r3v4X6hPgJGRiiP13Cg=;
        b=SVCTX84KQfto6of6LOHGl3AqeZAJ+IvR7PH8JEDFO4Pu8f5ibtZGa52ECm+9eZ5q2G
         G9i6uFz6yxKB88p3Ik0eEnZMTiaKmfe2FsP9cnmz3Vm/YLt1AhLv37zDXLBNsKMXmHK1
         OZAH1PUxY1RPUo8d7lLFDJ53rhPQJgHJz4i5InK+TxG+cqK7E60amYjxXbqsbxOFcp1+
         II1+oRL3mRc6cA4czMw/Z+tqS04ofJn1xiJfzP4F4Arqbzv5np3dtY4rsCRn7Mf2kaAl
         w9kOFpvu3VW6Q5hXd/tB+ldamMByklC8+nBXyG53wt4L3Y8EnDvQ+5Th3Bs8DbLnz+Sw
         QlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791895756; x=1792500556;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WOn8xr8BpKgnJ6Gee1th0C/2r3v4X6hPgJGRiiP13Cg=;
        b=Jfwedpo0ufkkyChI62p1jIzOijrjQw/oNvdmZKOqsKB8yHa9xXOo7fIsnYT55kQYTC
         +dJrV7YUCkeAqnmWUkyciHFaBJZxcZ5PoPQoGyRuLcvdYr3kgvv1g7suOG45z/G3oGF9
         Azt24fKovY3OhtLgQG9U3GbarNzrOJ4M3/352Nfc192DAHJYxmgz3wO2iEaLXZU5YPuY
         YMlccjx8f3fdoh+kkMtb+5lICC6MIwVRs/rJCgYJa1ZPRpvmsBHezKbCiB61UuFllSyU
         txfr52n30fXmrN+JHOAkwraXrR1FmbW9276BChli045wFNM3u+ZRMfdRCW4Hegi7sba1
         drZA==
X-Forwarded-Encrypted: i=1; AKwUvByMlqvx0LvhuJiuuX2Yu0OFwJzT/Qq25lpyr31l6k+xDCqNk7UIR1f3fp7ZkT5XEjMzSKqKmbe6Tng=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeqUJJaBriTtFSRn9lsHWvYLETad1873WUQ7FpyDs/CPTk09am
	3vrnnsB4vo8DyN3bXnIEy6OfDvZGxiOuGXluEvMPv5TJHVlDAyVG9ZLE
X-Gm-Gg: AYBFou3mwOB2CCWsCJCkjtxZKjVTovwdYlxZqKc/1vZ8/Z/dSlKlI0H7lVIXOmGq6of
	4SM+wH+19cF+9/NLsWn40JiDS5CXiEV+tJeZwZSp3im7ge+EOV24nQt9FYtPYDnW5QdZSAcAp1K
	2MUCWzVHp0m1K1LtUBOXEaiUtlwVu016EZY6dW1wPOL9Hv7psfxGDEw1FQX2e8zv7xMMbRrw3lA
	vadGKpScQKR5u4XBJ/DnZ2mBUZQp9UI3U+W2uYZ57pjZQszxmryYw2FFJlZCl3ybJWS+GW7fN4M
	iuAE8qVAyv4U2/B7n3mX6Byz/lLGywWDcivUAebvmPNdU5VbDlWTaFm4VW/OPuWKrbMgFE6uEzN
	+agLAEhOw+f1r627Wx6UC2yGB2U3/kGOQXw4PpFP1dMNAYCmsh7bIU7+q6xXcZHu7jL578458+F
	xNw5AS/lFylk5Z+Vq4btUkdLK/9XEKwQojwW/gvFrkPCfv+LT6UR/sp4yQGomDX6E3XsaMiEITR
	gkpZNKc+Tq16M7PvjGB7f9ztiOtx8HNvtywaJU9YlPXokLMzuKPy2Y6bTmijsCFI0MAx+wRkGdb
	0vUeZ1za
X-Received: by 2002:a05:6000:454c:b0:487:c3e:8df8 with SMTP id ffacd0b85a97d-48dba77cf87mr16911311f8f.5.1791895755870;
        Tue, 13 Oct 2026 05:49:15 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaa05sm4447635f8f.13.2026.10.13.05.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:49:15 -0700 (PDT)
Date: Tue, 13 Oct 2026 14:49:13 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	"Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Herve Codina <herve.codina@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Leonardo Costa <leonardo.costa@toradex.com>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/7] of: property: Make fw_devlink follow GPIO, PWM
 and clock nexus maps
Message-ID: <xipbz3gva66o56fjszlhioxgprcspwae7dwcqe7snub7wblts3@qqryckq5fau7>
References: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com>
 <a754faba-f904-458c-8ddb-7502e684c868@kontron.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a754faba-f904-458c-8ddb-7502e684c868@kontron.de>

On Tue, Oct 13, 2026 at 02:09:37PM +0200, Frieder Schrempf wrote:
> Hi Ernest,
> 
> On 10.09.26 16:16, Ernest Van Hoecke wrote:
> > [...]
> What is the status of this? Can you send a follow-up?
> 
> Frank is asking me to use nexus connector nodes and it looks like I will
> run into this issue.
> 
> Thanks
> Frieder

Hi Frieder,

I'll be sending a follow up very soon and address all the valuable
feedback I got here. Thanks for your interest!

Apologies for the delay, it's been quite busy here, but I also had some
nice chats about the topic at ELC 2026 last week so I'll follow up soon.

Kind regards,
Ernest
