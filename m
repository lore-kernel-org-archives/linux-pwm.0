From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH] pwm: imx27: Fix rounding behavior
Date: Tue, 2 Jun 2020 13:42:12 -0700
Message-ID: <20200602204211.GA1693@codeaurora.org>
References: <20200416080245.3203-1-u.kleine-koenig@pengutronix.de>
 <20200602124835.GF3360525@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200602124835.GF3360525@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

T24gVHVlLCBKdW4gMDIsIDIwMjAgYXQgMDI6NDg6MzVQTSArMDIwMCwgVGhpZXJyeSBSZWRpbmcg
d3JvdGU6Cj4gT24gVGh1LCBBcHIgMTYsIDIwMjAgYXQgMTA6MDI6NDVBTSArMDIwMCwgVXdlIEts
ZWluZS1Lw7ZuaWcgd3JvdGU6Cj4gPiBUbyBub3QgdHJpZ2dlciB0aGUgd2FybmluZ3MgcHJvdmlk
ZWQgYnkgQ09ORklHX1BXTV9ERUJVRwo+ID4gCj4gPiAgLSB1c2UgdXAtcm91bmRpbmcgaW4gLmdl
dF9zdGF0ZSgpCj4gPiAgLSBkb24ndCBkaXZpZGUgYnkgdGhlIHJlc3VsdCBvZiBhIGRpdmlzaW9u
Cj4gPiAgLSBkb24ndCB1c2UgdGhlIHJvdW5kZWQgY291bnRlciB2YWx1ZSBmb3IgdGhlIHBlcmlv
ZCBsZW5ndGggdG8gY2FsY3VsYXRlCj4gPiAgICB0aGUgY291bnRlciB2YWx1ZSBmb3IgdGhlIGR1
dHkgY3ljbGUKPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xl
aW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvcHdtL3B3bS1p
bXgyNy5jIHwgMjAgKysrKysrKysrKy0tLS0tLS0tLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4gCj4gQXBwbGllZCwgdGhhbmtzLgo+IAo+
IFRoaWVycnkKCkhpIFRoaWVycnksCgpKdXN0IEZZSSwgVGhpcyBjaGFuZ2UgY29uZmxpY3RzIHdp
dGggb25lIG9mIG15IHBhdGNoZXMgWzFdIGluIHRoZSAiQ29udmVydApQV00gcGVyaW9kIGFuZCBk
dXR5IGN5Y2xlIHRvIHU2NCIgc2VyaWVzLgoKWzFdOiBodHRwczovL3BhdGNod29yay5vemxhYnMu
b3JnL3Byb2plY3QvbGludXgtcHdtL3BhdGNoLzg0ODQ5NDcyNWZkMTI0MGVkODc3ZDBhMTQ3MWRk
MTFjY2VhMDFmZjUuMTU5MDUxNDMzMS5naXQuZ3VydXNAY29kZWF1cm9yYS5vcmcvCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
