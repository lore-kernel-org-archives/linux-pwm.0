Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D7D378D8C;
	Mon,  9 Mar 2026 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048246; cv=none; b=tfeC7nyAdX5Np+wThIdxZRofXOiwNRH1meLv/WEMbaRd5HERuWL3i+Uu3SDGUQNhst1DjthijIWdvq0Rj/gw2LXJFemV3peHxP3AJGSX4b4RYu878QkCYycJkR4XiydJtUaj0UClvx9RXY2h4rjJAGbZ2b0MDQ3YPI2WZEU52Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048246; c=relaxed/simple;
	bh=Wbr89A3pC7fyb62kcf4G5cW7lZdOd+yS6pEIC3JxxDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=QWf/iQxdmANleAvNB4Fn7nrKfbit2jDZjwdVQQ3oufaraBAuyq0YhDC6R8GEEQnQmYN75TaWq8Ar1ZCNP9g/yf3qUfvdI+SkQg9pQanUb678oS+mffcbp1SG/kWtxwiz/4R/lp7ouVZGjUPh5Bltv7ntIJtvA8ed6o8b60na9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Mon, 9 Mar 2026 17:23:45 +0800 (GMT+08:00)
Date: Mon, 9 Mar 2026 17:23:45 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v2 1/2] dt-bindings: pwm: dwc: add reset optional
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260307-charming-shrewd-mantis-54bf9f@quoll>
References: <20260306093000.2065-1-dongxuyang@eswincomputing.com>
 <20260306093058.2126-1-dongxuyang@eswincomputing.com>
 <20260307-charming-shrewd-mantis-54bf9f@quoll>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2d4f2cf9.3fe0.19cd1e8df20.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAHHaChka5pwdkGAA--.1178W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEBAmmtpQchr
	QABsr
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiA+IAo+ID4gQWRkIHRoZSBvcHRpb25hbCByZXNldHMgcHJvcGVydHkuCj4gCj4gV2h5Pwo+IAoK
SGkgS3J6eXN6dG9mLAoKVGhlIERlc2lnbldhcmUgUFdNIGNvbnRyb2xsZXIgcHJvdmlkZXMgc2Vw
YXJhdGUgcmVzZXQgc2lnbmFscyBkZWRpY2F0ZWTCoAp0byBlYWNoIGNsb2NrIGRvbWFpbiwgYXMg
c3BlY2lmaWVkIGluIHRoZSBoYXJkd2FyZSBkb2N1bWVudGF0aW9uLsKgCldpdGhvdXQgYXNzZXJ0
aW5nIGFuZCBkZWFzc2VydGluZyB0aGVzZSByZXNldHMgZHVyaW5nIHByb2JlLCB0aGUgUFdNwqAK
b3V0cHV0IG1heSByZW1haW4gaW4gYW4gdW5kZWZpbmVkIHN0YXRlIGFmdGVyIHN5c3RlbSByZWJv
b3QuCgpBZGQgb3B0aW9uYWwgcmVzZXQgY29udHJvbCBoYW5kbGluZyB0byBlbnN1cmUgdGhlIGNv
bnRyb2xsZXIgaXMKcHJvcGVybHkgaW5pdGlhbGl6ZWQuCgpXZSB3aWxsIHVwZGF0ZSB0aGUgY29t
bWl0IG1lc3NhZ2UgaW4gdGhlIG5leHQgdmVyc2lvbi4KCkJlc3QgcmVnYXJkcywKWHV5YW5nIERv
bmcKCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFh1eWFuZyBEb25nIDxkb25neHV5YW5nQGVzd2lu
Y29tcHV0aW5nLmNvbT4KPiAKPiBCZXN0IHJlZ2FyZHMsCj4gS3J6eXN6dG9mCg==
