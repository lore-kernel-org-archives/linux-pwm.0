From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] pwm: lpc18xx-sct: don't reconfigure PWM in .request and
 .free
Date: Fri, 16 Nov 2018 11:22:49 +0200
Message-ID: <1391bbe1-75b5-c86e-ed3a-1e1afb393917@mleia.com>
References: <20181114115025.GC2620@ulmo>
 <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

SGVsbG8gVXdlLAoKT24gMTEvMTYvMjAxOCAwODo1MiBBTSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3Jv
dGU6Cj4gUmVnYXJkaW5nIHRoZSAucmVxdWVzdCBjYXNlOiBUaGUgY29uc3VtZXIgbWlnaHQgYmUg
aW50ZXJlc3RlZCBpbiB0YWtpbmcKPiBvdmVyIHRoZSBjb25maWd1cmVkIHN0YXRlIGZyb20gdGhl
IGJvb3QgbG9hZGVyLiBTbyB0aGUgaW5pdGlhbGx5Cj4gY29uZmlndXJlZCBzdGF0ZSBzaG91bGQg
YmUgcmV0YWluZWQuCj4gCj4gRm9yIHRoZSBmcmVlIGNhc2UgdGhlIFBXTSBjb25zdW1lciBpcyBy
ZXNwb25zaWJsZSB0byBkaXNhYmxlIHRoZSBQV00KPiBiZWZvcmUgY2FsbGluZyBwd21fcmVsZWFz
ZSBhbmQgdGhlcmUgYXJlIHRocmVlIHN1YmNhc2VzIHRvIGNvbnNpZGVyOgo+IAoKdGhlIGNoYW5n
ZXMgYXJlIGZpbmUgcGVyIHNlLCBidXQgcGxlYXNlIHNwbGl0IHRoZW0gaW50byB0d28uCgpQcm9i
YWJseSBwd21fZGlzYWJsZSgpIG1pc3VzYWdlIGJlZ2FuIHNwcmVhZGluZyBmcm9tIGNvbW1pdCA1
NGIyYTk5OWExNjc1LgoKLS0KQmVzdCB3aXNoZXMsClZsYWRpbWlyCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
