Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010032.outbound.protection.outlook.com [52.101.228.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A350B3A1A55;
	Mon, 24 Aug 2026 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560638; cv=fail; b=Qj2OWgWLlJUcY4hckWp/p11u02xhDUuSD6sjzVHXO8dLy2dtz/v7HZ4IL0RC1IipB53NYXTtwLLhSerAk30wklV5uCO5SZSLIufp9/X8gEPdIiF86/TFj7XNAkJ9acelt0pmaC5BbCypkKF+X0qWXNzt2ruOTdOjkHgB4UvGv5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560638; c=relaxed/simple;
	bh=9RLbPgAKrRZkkOWuqHXeHCkRP0nAFZUUeYcKGZ3Pt5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=njiEBlkvuBksCTOapAOqiUVIppZzxaCD8pnSXXsV9OUL2CtiI5/yAscLpquD9/b/THkAx25NExV5QKXZ8IEU/sjLYxxYwsYaG32Sf/7ogfvK6G+L3Ly0WIpy+fcpqXGi1DP05x2iT8txMLAKTmYE0SD8ssPN38hrj1tJAEgDKhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=kgVxB3TH; arc=fail smtp.client-ip=52.101.228.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="kgVxB3TH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1c4aoJ4GRYW5Olo2wYzZ6BDOxSUQik0d6IU4rjE4d2LKHBRFOApGE7QLfa2NGUI6gExm/D+1ttjdJk1kBOjNeq+wjol574/CSGvUs8ucrYXK1fQaD2yGqaBstFU8BgiePnqiow4mXcZM01UbbozQxMw6i0BoC9wMZSDH2r6sZ7pDVraLFl9z+G/9R/gfv+YOkKDDOmFU1X+VKAnVmA6T7xhMZxNuUEv6zxR0Hp6Sq5FhTFTV9p3kOS+pBP/qj3xOWSL/uSo10dKbq7AupG9qJ68DGf4D/ABJHoCRifkbCEi5DmH+8V25EA8KsgpJJ19nI1O3r9FBRSHR5hka/nV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RLbPgAKrRZkkOWuqHXeHCkRP0nAFZUUeYcKGZ3Pt5c=;
 b=Lz5KVA4OE91LDQGhuaYp1ZGcnvZf0q3k8+i/v0/4ISCM7Dhj7Z3ICQvmDBXhsog+v1x4rKhyyZ9+Q0G5yATR8Y+g9W6kYtslLC7aLzXvkRLVesvQxFvbVlJweNQJEyo3ikx+BhvUSInLtH9ZzACiHuoQHON8PdN694aU/wteKu6ZW/WMm0soBZ96hH1ekMr99o090LPyiVfzZu1EDSSZ97iJfuoXJ9yIZ+MyjnUBiczgTDnnxMoiO0QvshbSaZfefCDJcqaANpWb1ZTlEJ/+SMmc3c7VYCjQ/+bIm6RSzUIIoGriWLk8AWAEURjWilskMXK+JZJSI505jkw/9Gxuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RLbPgAKrRZkkOWuqHXeHCkRP0nAFZUUeYcKGZ3Pt5c=;
 b=kgVxB3TH4cAHQqNV9UhFqoCzaBoSwLw0/GvhCydSS4EO01JoyOgEFF4OefxTUMV0/5uqSIG65liFymv8DpwSp6XUo4O9t/s0hNOATmZS4YqN4X6Z+Fm9jWtAYvqdyJvEW0qRVdCI7NfDxdK94vHln8FxXxrYp3bNeEJd0Zjtqss=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB13145.jpnprd01.prod.outlook.com (2603:1096:405:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:37:13 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 08:37:01 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: "biju.das.au" <biju.das.au@gmail.com>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "robh@kernel.org" <robh@kernel.org>,
	wsa+renesas <wsa+renesas@sang-engineering.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 02/11] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
Thread-Topic: [PATCH v6 02/11] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
Thread-Index: AQHc9Ah7y9VZk+j+YEifAJ7ShMwOEraXYPY/gBLMTCCAAykcAIAABohw
Date: Mon, 24 Aug 2026 08:37:01 +0000
Message-ID:
 <TY3PR01MB113465ED47CF52D8FBE04259686A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260604095647.108654-3-biju.das.jz@bp.renesas.com>
 <20260604100619.75EC51F00893@smtp.kernel.org> <aliM3iVA1LY7tW38@monoceros>
 <CADT+UeB-gV8QnuwpTUrHV-GvYPwebYg=RE68PcApZkACO4ENDw@mail.gmail.com>
 <TY3PR01MB11346EDD83D9CA3F3252D48F586A22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <aov6v5dObK-zJfRj@monoceros>
In-Reply-To: <aov6v5dObK-zJfRj@monoceros>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB13145:EE_
x-ms-office365-filtering-correlation-id: d9d85c36-a543-4784-1a39-08df01bade78
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|22082099003|4143699003|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 Lt12fsLK0eRsGjG+SAORrvwYm98/SzjERkobDiZT4HZiR6P0Zhnzr4+ktpBpEgW0dyh3QMSZHC9GiVEt/RtCI2oc0LNXoLh5b4+FQU8uV5bsKPB8tSMw0aCGaPhisYxf3+KKTILeiCGEDgT2h8Clx2L0ScvSM6mU8loTp8bQAzIwYKkHMoK4Hh1kHDo4KKiVmNRZjdG+GdU4UXV9ImPofJ4gWmIo/18QTStBhNwieiKGatwkL2+ibgqCtIUvZg4LpVMX3CrMwAwl2/1GZSR+ljQTzG6G7yhQRmh9y3dNJfbpFaxCxGvfCrTewNmkEWd3HNarzrEfaoVYoZmETCNPchAHFtsgWDuz/ETAAfO1ZW22g96oRAYNlfvbRb8bEmqm0820Rs7yvAjv/fasjtfyrD/1UmYMv/UhLWgtLQB1r/ANXLa5tx8qU1sIZI3vBmMT573AwdmcqSMhorH8DN+FDKczfGmQw6WxmqOMiXFUxc11XqaYtrP/2nEN9G1rRx3Xt+lrpypfyd0vrsL7CMtcVtXMVgxeIsIBfkeuqEsTZV7kPoKsvEBoFdx2gd/2xeqybjqBjA0ASriWJBn8lhSUJ86OAkQ/HxXor1HG41YjgAKtejuBa8VOtUbHajoI4jIwjIJ6mYcQJxu9WTywcYT1VWrpl3GwBz5jRbDHIRH1kxrSnUE5ipNWhAej4YofTabrkJBxCibKmHejSRukahTs/NDU9CFk+C2Y6KPZhmjoCRY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(22082099003)(4143699003)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SXGy8aMansUrF8dQ7k0k+ceoB/rMR+lwo4AutNf0YgsankXYnC+Cswq+6v?=
 =?iso-8859-1?Q?Nq6oiFDPb5Xx67yMR8jSDaiMk7gYaxMtXQawtgO5TXq5KqNKXdGFBBFb56?=
 =?iso-8859-1?Q?wfJAJxsxtpquUgtTh65k5b/YFjdK6/+60e0/0Qtpg21VLOox7klUrvHlfG?=
 =?iso-8859-1?Q?XnICnvrDqeAnowYKGUhj5xvUubszk6oZ7CSW+OUrVWFt6p7YrA2YAH2SQp?=
 =?iso-8859-1?Q?Bwvu+5qkvbJcijyZzDAyZb/1E3KO4+fAVLzzfnX0I37DMlPVE0cY19d8/D?=
 =?iso-8859-1?Q?gyphDznnBthCVH0N+XKUaj+9LFVDkjtJXPieC1xPYMuIG3UQLvzirt4+E5?=
 =?iso-8859-1?Q?BfDXdns700grO+JlEzLvZ6Ty3lvd+JZdpLCMZgVdh3nQQ7Vgcuxx4rz5QH?=
 =?iso-8859-1?Q?kXGUJDOJYGCZc2NrB1LHc8iL8D+jgNbymbYLcpNyD/PKQ1EnIEgtLK8N2J?=
 =?iso-8859-1?Q?MbkKtUvz43rNKkwzstj0fu2/ump5cmNHWzU/RTBdqCUwIwp0opQ6AuhQRW?=
 =?iso-8859-1?Q?/qDQ/mioagFSom/CmyiY9Q1tZ2Auo4YkeM61JFEZZIn4xu9NQeYxc1QEdS?=
 =?iso-8859-1?Q?n0PCoVolOCHc6ZBDUuLTl3vjTkDYxe+P3Vm5RgH/sziNgngE+N+wI4/tPV?=
 =?iso-8859-1?Q?VkQQ5S1n4rAKfHO+ijnBCmoV6LqPSAbVoG5vLQUs/BKmiKfTI88xGgv+20?=
 =?iso-8859-1?Q?BUS41Dj+5UIWP2t8olSk8vHANWN17mUcDL3duGMwLWB916dseb50bS86J5?=
 =?iso-8859-1?Q?D36g0ujDhUJYc5f/V+eOsn4DbqNhruoHi+jrsgK5bbu/86ZeDTDbUvN4b6?=
 =?iso-8859-1?Q?kPAD0oSK5b3AEYfedxXMxFit62nuUbqWIegBMdt2/WKGUeqKUoAWnOcSkQ?=
 =?iso-8859-1?Q?vic14j0sUueU0fPDoJu7G6LO/kGSGLVmBLcfjQNvyM+olTruX6VJDnay4n?=
 =?iso-8859-1?Q?MbFEWmJ/wwyJPc8CrGMwOJHKd4vm2C3TOVS5tYdx9mDHw0VIWDXCZrEv1X?=
 =?iso-8859-1?Q?l/1f0WomhlnzOjRxTOJKDwp+zxzG2kpRV46aXywbGEQqVCci/Fe54ZKHMN?=
 =?iso-8859-1?Q?/wJj4Wjrz7XNLxVWBwX5299SHsvM+qvuEv61huRMMN9bWretOQ47F5QLGE?=
 =?iso-8859-1?Q?o+Sc+A6rO603HKNp4P8t3qu+omiqVkLvTvPriCPZPq59572N2i3Km8QNqT?=
 =?iso-8859-1?Q?CNNbp28+AT8H5IvZpeI/f8yqdZt0Lr8EyWpvVUeWZAaqI5Uu2ToF+ntDuJ?=
 =?iso-8859-1?Q?37R2gn3GIM+wVskVNNFVOX6AcS1JjBSjvXrFYdQpyG7Jm3WjIYi3jXSdpx?=
 =?iso-8859-1?Q?k6ahCXFeI5GBaWvK38UaAmm2/5WYa4jc2MaCXg7Mf5jcIzSqzDAQTfiKu5?=
 =?iso-8859-1?Q?f0TwZSQV0yJ/kR+e7RaV2Cjfny+Yt4yM+Ptn2wRIq8voIDm3Fprqnmls8l?=
 =?iso-8859-1?Q?M+XFiCy1qRxzH6fChfQdxyi5PzxdMC3N+gqut8Rt7eMEKVxspwdcQwuAiD?=
 =?iso-8859-1?Q?rC8m4TpSe2uq9Fum6o9h71oQf5D96R3hsH3YLuaYHp0IieVrPXsudqiQqR?=
 =?iso-8859-1?Q?1dR5oqpga2uo1/GJ7vpoBXPHvCyDssHwfekTOpvOGVukCXCm3JPTbWYEFF?=
 =?iso-8859-1?Q?o/TRo1AOiEvloyi2xJC6aNVKn7uPxp0ElRWDeSRBJvDModwf4anL542zGg?=
 =?iso-8859-1?Q?w05cWDsukECw4/0WpWqLB7j/pxDfK9F9HtcDJr12LiPnrLcnJt1ki/YSq+?=
 =?iso-8859-1?Q?y3RGvn72J8upk6dnBLOMZx4fxWgf2vq2XNsPI0O5nLvvjKikL/ijgvscOk?=
 =?iso-8859-1?Q?XfjdrDuhKQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d85c36-a543-4784-1a39-08df01bade78
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 08:37:01.6862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YVEuheK6ijwkXk7Rz9Yiinx/lmq2Cp0AOsj0xqh5HUjwNbLpjqo6jYFgj9pPPWHmW8nZi6urVVHQlX1xr+/fhjQ2UppX3SpTySKQ+FWtsY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13145

Hi Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Sent: 24 August 2026 09:05
> Subject: Re: [PATCH v6 02/11] dt-bindings: pwm: rzg2l-gpt: Document renes=
as,poegs property
>=20
> Hello Biju,
>=20
> On Sat, Aug 22, 2026 at 07:54:26AM +0000, Biju Das wrote:
> > > -----Original Message-----
> > > From: Biju Das <biju.das.au@gmail.com>
> > > Sent: 10 August 2026 09:43
> > > Subject: Re: [PATCH v6 02/11] dt-bindings: pwm: rzg2l-gpt: Document
> > > renesas,poegs property
> > >
> > > Hi Uwe,
> > >
> > > I have clarified the use case with Rob on [1], and he acked on [2] .
> > > See the details below
> > >
> > > [1]
> > > https://lore.kernel.org/all/OS0PR01MB5922756F1836AAABFF62C04786049@O
> > > S0PR01MB5922.jpnprd01.prod.outlook.co
> > > m/
> > > [2]
> > > https://lore.kernel.org/all/20221215205843.4074504-3-biju.das.jz@bp.
> > > renesas.com/
> >
> > Is it ok, if I drop the POEG support as few SoCs such as RZ/T2H and
> > RZ/G3L needs PWM and this patch series is blocking them. Later I will s=
end patch for POEG.
> > Please let me know.
>=20
> You can also reorder to have the important bits first in the series. I ca=
n also apply partially then if
> I'm happy with the base support and there are still questions for POEG.

Ok, will do.

Cheers,
Biju
