Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.101.248.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093362;
	b=17R/Vl9WISByJaHmpLzfAzHNcVjMpa7Sm4l0qzKhc/PcmC090osOZFwl5xhGdKg5gN3H
	 Tp+RiWQls5B0aEZbWWumFHWb4H4f/poBGUoCfQF/yl9qdlOIiRmUSOMxAeq1ma4qoC1oL
	 Yqc8pgEnKsdUUpABDb+O/ln4tBcCPbL6J0TDexSpDRuK7Pxqsiq5DniWMvHd7TvvRkmPO
	 HkE1OmFDnpzJlbf/feN+ED/04VEhTXkb8L97xxajVU+5QdR0SDWqv9Ax77yKe92bXH07e
	 n+Oix6BK21nUCgmFqeC7OPYuxKcrvO/ET93L4FRle96JFyPTbauLa1B+b6THL4CykeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093362;
	h=DMARC-Filter:Received:X-Originating-IP:Date:X-CM-HeaderCharset:From:
	 To:Cc:Subject:X-Priority:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	 X-Coremail-Locale:X-CM-TRANSID:X-CM-SenderInfo:X-Coremail-Antispam;
	bh=CpKFKPZOdaTPUlj/tP8KSDwsqd4EwHcKrOyoIT9sVms=;
	b=yPvj27Q0zDyl7u0qJDCocS3WVYysGmBIer9hunnbI4v732pd9aWDCyS0+hBf71Ke6G2X
	 kvK0m3cboGKJyRPaaCyfArr+u2z1A0FRA2JC4elEHtyM1x2ZfkcsdBeEshvVUajRW04/B
	 PX/0Ri/LndQ4O2lK+F2cxfHCsQ/rQUIJxPnHHWqaFVqxNLTX4xtjEyufMHcrHnPrrtDV9
	 4zwwGU3rSNIkR3lZIIqsPOFleAdQgPhIHnl/U/hf9Luy2UWvv0a7ipS0PTFP4LDKRETdX
	 vCgBHmOF8/1v2FGxtx5BpyMLkaonX9NmfY/AgyQ5ZYWULGzXaDBbgH7EAedAzEAx9QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eswincomputing.com;
	spf=pass smtp.mailfrom=eswincomputing.com;
	arc=none smtp.remote-ip=46.101.248.176
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9447606A31A;
	Tue, 27 Oct 2026 09:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9447606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 27 Oct 2026 17:28:58 +0800 (GMT+08:00)
Date: Tue, 27 Oct 2026 17:28:58 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: ukleinek@kernel.org, daniel.lezcano@kernel.org, tglx@kernel.org,
	p.zabel@pengutronix.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, xuxiang@eswincomputing.com,
	wangguosheng@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	"Xuyang Dong" <dongxuyang@eswincomputing.com>
Subject: Re: Re: [PATCH v14 0/5] Update designware pwm driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <6a4cf05e.948b.19ff549073f.Coremail.dongxuyang@eswincomputing.com>
References: <20260730111425.1680-1-dongxuyang@eswincomputing.com>
 <6a4cf05e.948b.19ff549073f.Coremail.dongxuyang@eswincomputing.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <1905ec0b.b482.1a17cb103b0.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAHHaDabuBqoSGIAA--.13989W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgENAmrfgSsXN
	AABsx
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiAKPiA+IAo+ID4gVGhlcmUgaXMgYWxyZWFkeSBhIHBhdGNoIFsxXSBmb3IgdGhlIERlc2lnbldh
cmUgUFdNIGRyaXZlciwKPiA+IHdoaWNoIGlzIHBvc3RlZCBieSBCZW4gYW5kIHN0aWxsIHVuZGVy
IHJldmlldy4KPiA+IEJhc2VkIG9uIHRoaXMgcGF0Y2gsIHRoaXMgc2VyaWVzIGlzIGEgY29udGlu
dWF0aW9uIG9mIFsxXQo+ID4gdG8gYWRkIHN1cHBvcnQgZm9yIElQIHZlcnNpb25zIDIuMTFhIGFu
ZCBsYXRlciwgd2hpY2gKPiA+IGluY2x1ZGVzIHN1cHBvcnQgZm9yICJQdWxzZSBXaWR0aCBNb2R1
bGF0aW9uIHdpdGggMCUKPiA+IGFuZCAxMDAlIER1dHkgQ3ljbGUiLgo+ID4gCj4gPiBTdXBwb3J0
ZWQgY2hpcHM6Cj4gPiBFU1dJTiBFSUM3NzAwIHNlcmllcyBTb0MuCj4gPiAKPiA+IFRlc3Q6Cj4g
PiBUZXN0ZWQgdGhpcyBwYXRjaCBvbiB0aGUgU2lmaXZlIEhpRml2ZSBQcmVtaWVyIFA1NTAgKHdo
aWNoIHVzZXMgdGhlIEVJQzc3MDAKPiA+IFNvQykuCj4gPiAKPiA+IFsxXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzIwMjMwOTA3MTYxMjQyLjY3MTkwLTEtYmVuLmRvb2tzQGNvZGV0aGlu
ay5jby51ay8KPiA+IAo+ID4gVXBkYXRlczoKPiA+ICAgQ2hhbmdlcyBpbiB2MTQ6Cj4gPiAgIC0g
WUFNTDoKPiA+ICAgICAtIEFkZCAnUmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2lAb3NzLnF1YWxjb21tLmNvbT4nCj4gPiAgICAgICBmb3IgcGF0Y2gg
MS4KPiA+ICAgICAtIERyb3AgbWluSXRlbXMgb2YgcmVzZXQtbmFtZXMgcHJvcGVydHkuCj4gPiAg
ICAgLSBBZGQgdGhlIHJlc2V0cyBhbmQgcmVzZXQtbmFtZXMgcHJvcGVydGllcyBhbmQgcmVzdHJp
Y3Rpb25zIGZvcgo+ID4gICAgICAgb3RoZXIgY29tcGF0aWJsZSBzdHJpbmdzLgo+ID4gICAtIERy
aXZlcjoKPiA+ICAgICAtIFJlbW92ZSBNT0RVTEVfQUxJQVMoKSAoU2FzaGlrbyByZXZpZXcgb2Yg
djEzKS4KPiA+ICAgICAtIFVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UgYW5kIGNvbW1lbnQgZm9y
IHBhdGNoIDUuCj4gPiAgICAgICBUaGUgZXhjbHVzaXZlIHJlc2V0IHJlZmVyZW5jZXMgbXVzdCBi
ZSByZXRhaW5lZCBmb3IgdGhlIGxpZmV0aW1lCj4gPiAgICAgICBvZiB0aGUgdGltZXI6IHRoZSBo
YXJkd2FyZSBrZWVwcyBydW5uaW5nIGFmdGVyIGluaXQsIGFuZCBob2xkaW5nCj4gPiAgICAgICB0
aGUgcmVmZXJlbmNlcyBrZWVwcyB0aGUgcmVzZXRzIGRlYXNzZXJ0ZWQsIHByZXZlbnRpbmcgb3Ro
ZXIKPiA+ICAgICAgIGRldmljZXMgb24gdGhlIGJ1cyBmcm9tIHJlLWFzc2VydGluZyB0aGVtIChT
YXNoaWtvIHJldmlldyBvZiB2MTMpLgo+ID4gCj4gCgpIaSBVd2UsIERhbmllbCwgVGhvbWFzIGFu
ZCBQaGlsaXBwLAoKSnVzdCBhIGZyaWVuZGx5IHJlbWluZGVyIHJlZ2FyZGluZyB0aGlzIHNlcmll
cy4gQW55IGZlZWRiYWNrIG9yIGNvbW1lbnRzPwoKV2UgaGF2ZW4ndCByZWNlaXZlZCBhbnkgY29t
bWVudHMgeWV0LCBhcGFydCBmcm9tIHRoZSBzYXNoaWtvLWJvdCAod2hvc2XCoApwb2ludHMgd2Vy
ZSBhbHJlYWR5IGFkZHJlc3NlZCBpbiBwcmV2aW91cyB2ZXJzaW9ucykuCgpDb3VsZCB5b3UgcGxl
YXNlIGhlbHAgcmV2aWV3IHRoZSByZW1haW5pbmcgcGF0Y2hlcz/CoEkgd291bGQgYXBwcmVjaWF0
ZcKgCmFueSBmZWVkYmFjayBvciBzdWdnZXN0aW9ucyBvbiBob3cgdG8gcHJvY2VlZCB3aXRoIHRo
aXMgc2VyaWVzLCBvciBpZsKgCnRoZXJlIGlzIGFueXRoaW5nIGVsc2UgSSBzaG91bGQgZG8gdG8g
aGVscCBtb3ZlIGl0IGZvcndhcmQuwqAKClRoYW5rcyBmb3IgeW91ciB0aW1lIGFuZCBhdHRlbnRp
b24uCgpCZXN0IHJlZ2FyZHMsClh1eWFuZyBEb25nCgo=
