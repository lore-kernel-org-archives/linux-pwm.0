Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011060.outbound.protection.outlook.com [40.107.74.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE41D33AD8C;
	Mon, 27 Jul 2026 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147167; cv=fail; b=lTMeaXneJENxapBP3A3gUba6p05DjbUN6v9qMEJCVHq93RgNPm/iagAIN5oq0BU5kACpAKF3WyGIClr90tJ0EXXy/qwCv+mhU1/XOTUjLo92VRLW1713E/F2fteWCluOmEbrarRIR3Q7eCENrqpsIIdSvsUJLAij9OaimfnPMyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147167; c=relaxed/simple;
	bh=B+Us5Yi2UcJYuj8r8rRAUELEyXd0iX3PyRJETW3z9ow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UAtXjqDsTCUvzh0H2BLgAVbA8ug+H4UC5QlZQh80wJ0a43jMrxsGYQDDUwVS5lxbwrUy+UYBWguaofGiOyXYCIZxMBB5+xsU8mYvJeFGbxOti5j1iLk2KL41BGzChbG4+nxRTNIn0hIXOxLjVsvsAi71rcgJYiolErq6V8Kf/pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=NpVLheU1; arc=fail smtp.client-ip=40.107.74.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="NpVLheU1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sL+4z1R6W4CDpJJouFj8AVTdYxvBM5m7PLTXyemkhRauXj9v/JBbVZR4FApBQKAVvTFKKtqZ6ZWmcV7QguJGlX1K784PWr/8PkaUH+WYZQZm6Wpdr8O/NXb1+OMFdqZliyiwdV6eVTGMpvEp8vXwyDM1LgiOR0QBdJT9nJKZ/ZPj9dZvejcNE+nrKkOhwfX4u/+vvQkYO2vx7VFSyb/Arv0+gzyIltaOfRV9D2qCCU2Y2lGhAQnketzK2wnbD6NXao/sbcW3bQjJ9XGV5vZ974+HBwq3V+lOKKn1oV8fkWWpQSQJQS+GkVuFiEsBG8zLZGlGcuhrvXyqv4seISbHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMvSnnjRX2+xBf5oP73fRAgqTRWblsEB4YFl9su2/rA=;
 b=EuXRNjvbhjlm2Ys8ePrYUNu0qQiR027b0WE0gIw8og2ips5vd94GqMihBTYHNI9kQRUF0xvoM01AYY3omNK1j+f/DLwEt1QGjrrV05La/po46nxDnkaZWXNuAEgmImIdjGRyp0R6ZaU7HR5ASXqZSBS+4iuIrjgcyoNqde2MtN7FRGfqBFzHLyjBaAGNTYiF5D3tAJPEwg+2yz76nP/H8hdEawPirS4EDDT5gXBZDjTzgpyxHoasYRnb5T4mAj9JK6vyd8yCA84LWvbQxy/1Tv739CWwcny4rOXD+az3TvBhpxDcC3vImZcJpm2gv0yI6FK7w1PeM7Uc+YFPh6mBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMvSnnjRX2+xBf5oP73fRAgqTRWblsEB4YFl9su2/rA=;
 b=NpVLheU1Ag5+EPnWQGJe1VnmrsRCYck4mbt6SMG77cCIkxrKmIPW2iLkqqGbSsQcgclZMKcnfxm7wkFjbFhn/H1x1fV6fW5yga75LBaWIAo3oG2bTzPvDg44CId3A409267zWx13cgyAiTluWiDsDmDEUNZXP+V+wCDfbqyMEjs=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8571.jpnprd01.prod.outlook.com (2603:1096:604:19e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 10:12:42 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 10:12:42 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, "biju.das.au"
	<biju.das.au@gmail.com>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 06/11] pwm: rzg2l-gpt: Convert to waveform callbacks
Thread-Topic: [PATCH v6 06/11] pwm: rzg2l-gpt: Convert to waveform callbacks
Thread-Index: AQHc9Ah+Zqe66jN8J0uoBq5msFMgFLZwF0WAgBFhBAA=
Date: Mon, 27 Jul 2026 10:12:42 +0000
Message-ID:
 <TY3PR01MB11346293B0C51E263E139624F86CC2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
 <20260604095647.108654-7-biju.das.jz@bp.renesas.com>
 <aliXW2JWc6OoY9FG@monoceros>
In-Reply-To: <aliXW2JWc6OoY9FG@monoceros>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8571:EE_
x-ms-office365-filtering-correlation-id: 4d697251-5d0f-478c-f49a-08deebc798c7
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|22082099003|10067099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 t/RM8X962VZuuGwmoH7J32WFdfjlFgbk/OInGg4CnUaBnOjkWA4nczVX89/wAW/6y3E4irUL0RpQ2ggO6Nm6odW4oSrna02s7GVLdeNd7bhFvvNu/zdc/CHreZSW9PTy2pNU8MqJHjZ0BNcZjp1sZPfsr1ZTL1i+cIyPhhVfR2kovYxFyZScrPy47+gNRDn6KvIzelcAerdnXE9dYv4bUgRGJYQI1gAjJfW6hkzitf79JjSayvLlsuAr5aXXtCeyd1lcduJxF+jvDXfUsA9wo2MP8OBqxTjNDPvtIxT4uJGc2fcRHZGyJYuXteVxYI3doL8F9JjYri1WexCJyu2HoMsDKDs5LF/DXjID5qTFQ7AwM21M0qTFqjxQnoqDamLa+pZCjyqe15AfVbWWztYjssDUam110VY4d/6snI0jvKNlN2IHu2MUJdt/BxNcf23iw8yDXVsKF99FjPtniFSxd6PerMRT9wlOk9fW7loaU64M4FfnJGkm6KSGXJcwhmnffpotSxIgiYRVKPA9yEaVEjiybh6o4gDD/CiOjpQbUEdRSj33HhXMpParAl2Zfgi35JwrMcwRlbv3u0pw0nrHQl/MF7+G01afxWGPkDCqtu0Slk3pDcaLRSOnOz5o9du5Nx88Qbj9vqehgppfIBYsS9fJovaadO8euxhcI8bghj1OQDyMkS+189cAg4087w4aBjmpuPPURhrvZJi5/LW8XD7DCxC+qklNhzAO8rvpZhc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(22082099003)(10067099003)(18002099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dUQF/otyZ5R1dDeEE7ShtqnE/9Yw/vqI0DVquAaeGHGW/U5A4OrNPWRePn?=
 =?iso-8859-1?Q?31+aMxMaHC3fzwtkqQ0Qno6oTpXFaTMKDjgXMQUgtYdJ6YJ2T/gvvMv4/b?=
 =?iso-8859-1?Q?y3fNRzJP46jaPJoX4jP4gv01Kti2SxXNZPcD+Ggn1Y5Ff9NajjyNZy2vna?=
 =?iso-8859-1?Q?Rxfy1Hdkz7KK1kXAJOn30uD1zzB4gth4g0ar1faiAJogJu6pbS6rDNYdQe?=
 =?iso-8859-1?Q?LXm6Um5uM+enGoFT8JJyke0aNT/30Vkw7H0xze36XxKOpMOOuZs19qDjd5?=
 =?iso-8859-1?Q?nWTAjVaXFNQO5/gMGydlv0Hd71ctQZnX6dTE81aV0mIOTBhFl4ols+1FCt?=
 =?iso-8859-1?Q?LSOcKSUPGuhAS8tu1LBqyiodSQqDg6l0lq5LkxpVUxc9/Byg8OzyQRvQb4?=
 =?iso-8859-1?Q?rK37k85B0weZwF4GU0skdiq45DVABQ9+YNCuiPzbbJ6zZTCteK/0NHCVOf?=
 =?iso-8859-1?Q?BbQFbgWYBKGcJmqkWAxdCBNWPfcNiBAJZmHsvpOMPl+ScH1vKcmMNUOKDl?=
 =?iso-8859-1?Q?9r+hVNLIRKSn+IYUeKTrFVv3hLeWbOFtDpVFH9a60M17GGB68KXeV1oGiQ?=
 =?iso-8859-1?Q?j5uNz0y0AVdSaaSiD9Ur7QDa4Qbbau7vl/x5hV7ftrBUlJm3Yb3w5OiTH9?=
 =?iso-8859-1?Q?+8N0f/dznVU0fHl/Z+4Z/OX662TxpcR8E/bKiHxDuqtWe5YhQF4kmvdMmo?=
 =?iso-8859-1?Q?kD51qvIx8urKPLf4J8maLW9ysnLM4mOr8+955ux68AeP8snJC6FAzy/WRg?=
 =?iso-8859-1?Q?JP7RCtZhxrajvnoYtyOgswOn86LFbQg9luoj4aKj2APi3ydpapuCSvWO3k?=
 =?iso-8859-1?Q?HGJsTU7Iz9AilAYdwntV9j98N03r4+IXUkpHrF1UM2Bfy6ONPULuYB9d2U?=
 =?iso-8859-1?Q?5Z0Rr+B8GkQ4agJyDLqczArIo+dpXzlmqKgKoQt+JqZD+apfIQEvWr9PHT?=
 =?iso-8859-1?Q?k2vDeKyF4KkP7FcerDjWMEQAxkgvbqX3rZ4MIrzWEXCCb7yLpUIZDISblq?=
 =?iso-8859-1?Q?3iARpOt44/dJyLB9Pbjkb3rPbi5r1+JpnttI1iKZ5BI8H/16GZSJhWdpIF?=
 =?iso-8859-1?Q?Jf9VDRVfNPtpMhLbchW9x3eW6xaBZmF8DQsLwbX0pYAK1t9uVpTKO7ofdi?=
 =?iso-8859-1?Q?r7TaTn91zcmrou9rugoKceQN88YOi2jbJg8A7XbB64tODgURuA+qblo96M?=
 =?iso-8859-1?Q?FH5idD/42m+houhEa/seLL5IBarUZ8R5ATfnqbxPpDdJK3QwlBI+vdY3Rq?=
 =?iso-8859-1?Q?hNM0JPLR5vQouf47V7TiIkvD0sQTQqJTTgwQ9IIici3Vx0q2U6Fe/ZScLb?=
 =?iso-8859-1?Q?0PQdCK94Sb4ZSiKfaJpa22fd0J+PSaWWwZ42D07jtPfkOBvnGVzgmrYx+1?=
 =?iso-8859-1?Q?lu5woyxWSC3Ikvwkhm4YTtzocywRguNrNJV8dlklgnnXgjuMbD31pqMyhV?=
 =?iso-8859-1?Q?U2sllb8XjUFmR0j5rw6VvTRPTKv1GWR/VZDcyJQRvC7lK6sd2T5QUYY9jE?=
 =?iso-8859-1?Q?8XvcJlALZBNYWqng2lNImpHQlAmCmR7lzNXjsW33nFohe6JpvlZA2IYLsj?=
 =?iso-8859-1?Q?SBMVVKle8P82CZJU+XA9Qjf+FSWKZ0LaW/lGQtxSqmAPtXd6+7dveO6B/6?=
 =?iso-8859-1?Q?f/OaNgYXXzj91sCop1/5xC0f8RqGLjVHRfO9C/C0ufbJU5Qo0CUXzKNd42?=
 =?iso-8859-1?Q?9qH8um7F8OVMI23MlJVHxLyttI9N02yniP+4te8hZfTD/CVwUab8sXP20C?=
 =?iso-8859-1?Q?5MpUpLBAq3BWu6AdOUMJHEGH8G2dtxJ4tLOsDmr2apCU2A7uzls+cn4Qus?=
 =?iso-8859-1?Q?I0Pb3KO64A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d697251-5d0f-478c-f49a-08deebc798c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 10:12:42.7310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tuwqQLQRYQDqaDeTGvZlZq4Gu4OSKCQW8LYJqZx4JGzU2krJLSSScHXPPVwOy9Id46kuI4C3ToGvURi+H5jh/klUs8MJDKitqGPjxJaOPCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8571

Hello Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 16 July 2026 09:47
> Subject: Re: [PATCH v6 06/11] pwm: rzg2l-gpt: Convert to waveform callbac=
ks
>=20
> Hello Biju,
>=20
> On Thu, Jun 04, 2026 at 10:56:36AM +0100, Biju wrote:
> > @@ -291,29 +285,84 @@ static int rzg2l_gpt_config(struct pwm_chip *chip=
, struct pwm_device *pwm,
> >  	if (rzg2l_gpt->channel_request_count[ch] > 1) {
> >  		u8 sibling_ch =3D rzg2l_gpt_sibling(pwm->hwpwm);
> >
> > -		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch)) {
> > +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch, NULL)) {
> >  			if (period_ticks < rzg2l_gpt->period_ticks[ch])
> > -				return -EBUSY;
> > +				is_small_second_period =3D true;
> >
> >  			period_ticks =3D rzg2l_gpt->period_ticks[ch];
> >  		}
> >  	}
> >
> > -	prescale =3D rzg2l_gpt_calculate_prescale(period_ticks);
> > -	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
> > +	wfhw->prescale =3D rzg2l_gpt_calculate_prescale(period_ticks);
> > +	wfhw->gtpr =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->presc=
ale);
> > +	wfhw->gtccr =3D 0;
> > +	if (is_small_second_period)
>=20
> If is_small_second_period =3D=3D true, the prescale doesn't need to be re=
calculated as the other twin already
> has this configured? But not sure that reading the value (or storing it i=
n drvdata) is better/faster than
> recalculating. So judge yourself.

OK, will calculate prescale in else path, so it won't be recalculated.

> Also moving
> `wfhw->gtccr =3D 0` into the if block reduces (my) confusion a bit.

Agreed.

>=20
> > +		return 1;
> >
> > -	duty_ticks =3D mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate=
_khz, USEC_PER_SEC);
> > +	duty_ticks =3D mul_u64_u64_div_u64(wf->duty_length_ns,
> > +rzg2l_gpt->rate_khz, USEC_PER_SEC);
>=20
> NSEC_PER_MSEC would be more logically sound here. (But this is a pre-exis=
ting mini issue.)

OK, will ad a patch for fixing this.

Cheers,
Biju
