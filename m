Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F84391517;
	Wed, 12 Aug 2026 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526665; cv=none; b=cL5lUrrDHnbB2VlO2r2kU5H5nhXer5ArUA9WY3LC/UD9+lmGYbskIC00zsLXUtvMm5i5f7pyxMfQclIU0CZdGDxc2F+NT7HRrizQQtsh1Ohlg6F4/ZKh/EE3qhyPotPd69oRm1xarFiAD/W8k556tMjV6zmw9kLbRtA1Im0iC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526665; c=relaxed/simple;
	bh=rxkM1KQ6LYaLEjQiZmalf3gN3z7fUynbMwmvmwTODYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=jZLZtozTo3QfL4zmabM9oTgcGikiO+/rOboFUR5vVxEuudd/0iRHUhx/DmJp7ZC1fza5ek9UNT6Z4it5/tWxetTId4lk0wuZ2VvO8HKsVt3FqfUotl81vKKWPkX8LgTLdXq0G9Sc8+gb7zdCkM2LZjb3ChQyIOobXefz6BvWCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Wed, 12 Aug 2026 17:23:51 +0800 (GMT+08:00)
Date: Wed, 12 Aug 2026 17:23:51 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: ukleinek@kernel.org, daniel.lezcano@kernel.org, tglx@kernel.org
Cc: p.zabel@pengutronix.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, xuxiang@eswincomputing.com,
	wangguosheng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v14 0/5] Update designware pwm driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260730111425.1680-1-dongxuyang@eswincomputing.com>
References: <20260730111425.1680-1-dongxuyang@eswincomputing.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6a4cf05e.948b.19ff549073f.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAnPJ+nO3xqOzM7AA--.8869W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgERAmp7Tx8Vf
	AABs5
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiAKPiBUaGVyZSBpcyBhbHJlYWR5IGEgcGF0Y2ggWzFdIGZvciB0aGUgRGVzaWduV2FyZSBQV00g
ZHJpdmVyLAo+IHdoaWNoIGlzIHBvc3RlZCBieSBCZW4gYW5kIHN0aWxsIHVuZGVyIHJldmlldy4K
PiBCYXNlZCBvbiB0aGlzIHBhdGNoLCB0aGlzIHNlcmllcyBpcyBhIGNvbnRpbnVhdGlvbiBvZiBb
MV0KPiB0byBhZGQgc3VwcG9ydCBmb3IgSVAgdmVyc2lvbnMgMi4xMWEgYW5kIGxhdGVyLCB3aGlj
aAo+IGluY2x1ZGVzIHN1cHBvcnQgZm9yICJQdWxzZSBXaWR0aCBNb2R1bGF0aW9uIHdpdGggMCUK
PiBhbmQgMTAwJSBEdXR5IEN5Y2xlIi4KPiAKPiBTdXBwb3J0ZWQgY2hpcHM6Cj4gRVNXSU4gRUlD
NzcwMCBzZXJpZXMgU29DLgo+IAo+IFRlc3Q6Cj4gVGVzdGVkIHRoaXMgcGF0Y2ggb24gdGhlIFNp
Zml2ZSBIaUZpdmUgUHJlbWllciBQNTUwICh3aGljaCB1c2VzIHRoZSBFSUM3NzAwCj4gU29DKS4K
PiAKPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDkwNzE2MTI0Mi42NzE5
MC0xLWJlbi5kb29rc0Bjb2RldGhpbmsuY28udWsvCj4gCj4gVXBkYXRlczoKPiAgIENoYW5nZXMg
aW4gdjE0Ogo+ICAgLSBZQU1MOgo+ICAgICAtIEFkZCAnUmV2aWV3ZWQtYnk6IEtyenlzenRvZiBL
b3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAb3NzLnF1YWxjb21tLmNvbT4nCj4gICAgICAg
Zm9yIHBhdGNoIDEuCj4gICAgIC0gRHJvcCBtaW5JdGVtcyBvZiByZXNldC1uYW1lcyBwcm9wZXJ0
eS4KPiAgICAgLSBBZGQgdGhlIHJlc2V0cyBhbmQgcmVzZXQtbmFtZXMgcHJvcGVydGllcyBhbmQg
cmVzdHJpY3Rpb25zIGZvcgo+ICAgICAgIG90aGVyIGNvbXBhdGlibGUgc3RyaW5ncy4KPiAgIC0g
RHJpdmVyOgo+ICAgICAtIFJlbW92ZSBNT0RVTEVfQUxJQVMoKSAoU2FzaGlrbyByZXZpZXcgb2Yg
djEzKS4KPiAgICAgLSBVcGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlIGFuZCBjb21tZW50IGZvciBw
YXRjaCA1Lgo+ICAgICAgIFRoZSBleGNsdXNpdmUgcmVzZXQgcmVmZXJlbmNlcyBtdXN0IGJlIHJl
dGFpbmVkIGZvciB0aGUgbGlmZXRpbWUKPiAgICAgICBvZiB0aGUgdGltZXI6IHRoZSBoYXJkd2Fy
ZSBrZWVwcyBydW5uaW5nIGFmdGVyIGluaXQsIGFuZCBob2xkaW5nCj4gICAgICAgdGhlIHJlZmVy
ZW5jZXMga2VlcHMgdGhlIHJlc2V0cyBkZWFzc2VydGVkLCBwcmV2ZW50aW5nIG90aGVyCj4gICAg
ICAgZGV2aWNlcyBvbiB0aGUgYnVzIGZyb20gcmUtYXNzZXJ0aW5nIHRoZW0gKFNhc2hpa28gcmV2
aWV3IG9mIHYxMykuCj4gCgpIaSBVd2UsIERhbmllbCwgYW5kIFRob21hcywKCkp1c3QgYSBnZW50
bGUgcmVtaW5kZXIgb24gdGhpcyBzZXJpZXMuIFRoaXMgcGF0Y2ggc2VyaWVzIGhhcyByZWNlaXZl
ZMKgClJldmlld2VkLWJ5IGFuZCBBY2tlZC1ieSB0YWdzIGZyb20gS3J6eXN6dG9mIG9uIHRoZSBi
aW5kaW5ncyBwb3J0aW9uLsKgCkZvciB0aGUgZHJpdmVyIHBhcnQsIEkgaGF2ZSBhbHJlYWR5IHJl
c3BvbmRlZCB0byBTYXNoaWtvJ3MgcmV2aWV3wqAKY29tbWVudHMgYW5kIHByb3ZpZGVkIGV4cGxh
bmF0aW9ucy4KCkNvdWxkIHlvdSBwbGVhc2UgaGVscCByZXZpZXcgdGhlIHJlbWFpbmluZyBwYXRj
aGVzPyBJIHdvdWxkIGFwcHJlY2lhdGXCoAphbnkgZnVydGhlciBmZWVkYmFjayBvciBzdWdnZXN0
aW9ucyBvbiBob3cgdG8gcHJvY2VlZCB3aXRoIHRoaXMgc2VyaWVzLgoKVGhhbmtzIGZvciB5b3Vy
IHRpbWUgYW5kIGF0dGVudGlvbi4KCkJlc3QgcmVnYXJkcywKWHV5YW5nIERvbmcKCg==
